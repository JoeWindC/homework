package com.ouyeni.ylggxt.service.impl;

import com.ouyeni.ylggxt.entity.Registration;
import com.ouyeni.ylggxt.mapper.RegistrationMapper;
import com.ouyeni.ylggxt.service.RegistrationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
// 挂号预约业务实现：
// 普通用户负责提交和撤销自己的预约，管理员负责确认、完成和取消预约。
public class RegistrationServiceImpl implements RegistrationService {
    @Resource
    private RegistrationMapper registrationMapper;

    @Override
    // 管理员查看全部预约。
    // 这个方法用于后台总览。
    public List<Registration> listAll() {
        return registrationMapper.findAll();
    }

    @Override
    // 普通用户查看自己的预约记录。
    // 这里只传 userId，所以天然只会返回当前登录用户的数据。
    public List<Registration> listMine(Integer userId) {
        return registrationMapper.findByUserId(userId);
    }

    @Override
    // 用于叫号屏/队列页展示的预约列表。
    // 只筛选待处理和已确认，符合门诊叫号的现实流程。
    public List<Registration> listQueue() {
        return registrationMapper.findQueueList();
    }

    @Override
    // 统计全部预约数量。
    // 首页统计卡片会显示这个数字。
    public int countAll() {
        return registrationMapper.countAll();
    }

    @Override
    // 统计待处理预约数量。
    // 这是首页和叫号屏都常用的指标。
    public int countPending() {
        return registrationMapper.countPending();
    }

    @Override
    @Transactional
    // 提交挂号预约：
    // 1. 校验必填项
    // 2. 默认写成“待处理”
    // 3. 交给管理员后续确认
    // 这是普通用户真正“提交挂号”的核心入口。
    public String save(Registration registration) {
        if (isBlank(registration.getDepartment())) {
            return "请选择就诊科室";
        }
        if (isBlank(registration.getVisitDate())) {
            return "请选择就诊日期";
        }
        if (isBlank(registration.getTimePeriod())) {
            return "请选择就诊时段";
        }
        if (isBlank(registration.getPatientName())) {
            return "请填写就诊人姓名";
        }
        if (isBlank(registration.getPhone())) {
            return "请填写联系电话";
        }
        registration.setStatus("待处理");
        registrationMapper.insert(registration);
        return "success";
    }

    @Override
    @Transactional
    // 管理员更新预约状态。
    // 这里限制状态值，只允许已确认/已完成/已取消，避免脏数据。
    // 状态枚举越明确，后面页面渲染和统计越稳定。
    public void changeStatus(Integer id, String status) {
        if ("已确认".equals(status) || "已完成".equals(status) || "已取消".equals(status)) {
            registrationMapper.updateStatus(id, status);
        }
    }

    @Override
    @Transactional
    // 普通用户取消自己的待处理预约。
    // 取消操作最终还会在 Mapper 层校验 userId 和 status。
    public void cancel(Integer id, Integer userId) {
        registrationMapper.deleteById(id, userId);
    }

    private boolean isBlank(String value) {
        // 小工具：统一判断字符串是否为空白。
        return value == null || value.trim().isEmpty();
    }
}
