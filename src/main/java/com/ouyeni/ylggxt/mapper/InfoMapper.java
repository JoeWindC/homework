package com.ouyeni.ylggxt.mapper;

import com.ouyeni.ylggxt.entity.Info;
import org.apache.ibatis.annotations.Param;

import java.util.List;

// 公告表 MyBatis 映射接口。
public interface InfoMapper {
    List<Info> findAll();

    List<Info> search(@Param("keyword") String keyword, @Param("category") String category);

    Info findById(Integer id);

    int countAll();

    int insert(Info info);

    int update(Info info);

    int deleteById(Integer id);
}
