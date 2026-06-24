package com.ouyeni.ylggxt.mapper;

import com.ouyeni.ylggxt.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

// 用户表 MyBatis 映射接口。
public interface UserMapper {
    User findByUsername(String username);

    User login(@Param("username") String username, @Param("password") String password);

    List<User> findAll();

    int countAll();

    int countEnabled();

    int insert(User user);

    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);

    int deleteById(Integer id);
}
