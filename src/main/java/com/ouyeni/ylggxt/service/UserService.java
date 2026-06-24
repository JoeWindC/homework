package com.ouyeni.ylggxt.service;

import com.ouyeni.ylggxt.entity.User;

import java.util.List;

// 用户业务接口：定义注册、登录和用户管理能力。
public interface UserService {
    // 注册普通用户，返回错误提示；返回 null 表示注册成功。
    String register(User user);

    User login(String username, String password);

    List<User> listUsers();

    int countUsers();

    int countEnabledUsers();

    void changeStatus(Integer id, Integer status);

    void deleteUser(Integer id);
}
