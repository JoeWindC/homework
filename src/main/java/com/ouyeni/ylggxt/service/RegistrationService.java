package com.ouyeni.ylggxt.service;

import com.ouyeni.ylggxt.entity.Registration;

import java.util.List;

// 挂号预约业务接口：定义列表、提交、状态和取消能力。
public interface RegistrationService {
    // 管理员查询全部挂号预约。
    List<Registration> listAll();

    // 普通用户查询自己的挂号预约。
    List<Registration> listMine(Integer userId);

    // 查询叫号队列中需要展示的预约。
    List<Registration> listQueue();

    // 统计全部预约数量。
    int countAll();

    // 统计待处理预约数量。
    int countPending();

    // 提交预约，返回 success 表示成功，否则返回错误原因。
    String save(Registration registration);

    // 管理员修改预约状态。
    void changeStatus(Integer id, String status);

    // 普通用户取消自己的待处理预约。
    void cancel(Integer id, Integer userId);
}
