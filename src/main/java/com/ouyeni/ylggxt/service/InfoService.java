package com.ouyeni.ylggxt.service;

import com.ouyeni.ylggxt.entity.Info;

import java.util.List;

// 公告业务接口：定义公告查询和维护能力。
public interface InfoService {
    // 查询公告列表。
    List<Info> listInfos();

    // 按关键字和分类搜索公告。
    List<Info> searchInfos(String keyword, String category);

    // 根据 ID 查询公告详情。
    Info getInfo(Integer id);

    // 统计公告总数。
    int countInfos();

    // 保存新公告。
    void saveInfo(Info info);

    // 更新已有公告。
    void updateInfo(Info info);

    // 删除公告。
    void deleteInfo(Integer id);
}
