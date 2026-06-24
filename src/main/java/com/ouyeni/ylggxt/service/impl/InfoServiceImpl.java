package com.ouyeni.ylggxt.service.impl;

import com.ouyeni.ylggxt.entity.Info;
import com.ouyeni.ylggxt.mapper.InfoMapper;
import com.ouyeni.ylggxt.service.InfoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
// 公告业务实现：
// 公告内容所有人可读，新增/编辑/删除只允许管理员。
public class InfoServiceImpl implements InfoService {
    @Resource
    private InfoMapper infoMapper;

    @Override
    // 获取全部公告列表。
    public List<Info> listInfos() {
        return infoMapper.findAll();
    }

    @Override
    // 按关键字和分类搜索公告。
    // 如果没有填任何条件，就直接查全部公告。
    public List<Info> searchInfos(String keyword, String category) {
        String cleanKeyword = keyword == null ? "" : keyword.trim();
        String cleanCategory = category == null ? "" : category.trim();
        if (cleanKeyword.isEmpty() && cleanCategory.isEmpty()) {
            return infoMapper.findAll();
        }
        return infoMapper.search(cleanKeyword, cleanCategory);
    }

    @Override
    // 按 ID 获取公告详情。
    public Info getInfo(Integer id) {
        return infoMapper.findById(id);
    }

    @Override
    // 统计公告总数。
    public int countInfos() {
        return infoMapper.countAll();
    }

    @Override
    @Transactional
    // 新增公告。
    public void saveInfo(Info info) {
        infoMapper.insert(info);
    }

    @Override
    @Transactional
    // 更新公告。
    public void updateInfo(Info info) {
        infoMapper.update(info);
    }

    @Override
    @Transactional
    // 删除公告。
    public void deleteInfo(Integer id) {
        infoMapper.deleteById(id);
    }
}
