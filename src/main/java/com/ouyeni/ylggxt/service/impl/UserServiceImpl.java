package com.ouyeni.ylggxt.service.impl;

import com.ouyeni.ylggxt.entity.User;
import com.ouyeni.ylggxt.mapper.UserMapper;
import com.ouyeni.ylggxt.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
// 用户业务实现：
// 1. 注册时默认写成普通用户 user
// 2. 登录时检查账号、密码和启用状态
// 3. 管理员的用户管理动作只做数据库更新，不做页面跳转
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;

    @Override
    @Transactional
    // 注册时先做空值和唯一性校验，再写入默认普通用户状态。
    // 这里强制 setRole("user")，避免前端自己传 role=admin。
    // 注册入口只能创建普通用户，这是权限设计的第一道防线。
    public String register(User user) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return "账号不能为空";
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return "密码不能为空";
        }
        if (userMapper.findByUsername(user.getUsername()) != null) {
            return "账号已存在，请更换账号";
        }
        user.setRole("user");
        user.setStatus(1);
        userMapper.insert(user);
        return null;
    }

    @Override
    // 登录时校验账号、密码和启用状态。
    // 如果账号被禁用，这里会返回 null，前面控制器就会拦住登录。
    // 这里返回 User 对象，方便控制器把它放进 Session。
    public User login(String username, String password) {
        User user = userMapper.login(username, password);
        if (user != null && user.getStatus() != null && user.getStatus() == 1) {
            return user;
        }
        return null;
    }

    @Override
    // 查询所有用户，供管理员页面展示。
    // 这里返回列表，不负责页面渲染。
    public List<User> listUsers() {
        return userMapper.findAll();
    }

    @Override
    // 统计用户总数。
    // 首页工作台会用这个数字做统计卡片。
    public int countUsers() {
        return userMapper.countAll();
    }

    @Override
    // 统计已启用用户数量。
    // 这个数字用来展示系统当前可正常登录的用户数。
    public int countEnabledUsers() {
        return userMapper.countEnabled();
    }

    @Override
    @Transactional
    // 切换用户状态。
    // 页面上的“启用/禁用”按钮，最后就是调用这个方法改 status。
    // 这里不允许修改管理员账号，真正限制在 Mapper SQL 中。
    public void changeStatus(Integer id, Integer status) {
        userMapper.updateStatus(id, status);
    }

    @Override
    @Transactional
    // 删除普通用户。
    // 管理员删除的是普通账号，不会删除 admin。
    public void deleteUser(Integer id) {
        userMapper.deleteById(id);
    }
}
