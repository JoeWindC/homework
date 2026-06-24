package com.ouyeni.ylggxt.controller;

import com.ouyeni.ylggxt.entity.User;
import com.ouyeni.ylggxt.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/users")
// 用户管理控制器：
// 这个页面是管理员面板，普通用户即使知道地址，也会被重定向回首页。
public class UserController {
    @Resource
    private UserService userService;

    @GetMapping
    // 用户列表页：
    // 先从 Session 里取当前登录用户，再判断 role 是否为 admin。
    // 这就是“为什么普通用户进不去管理员面板”的后端判断点。
    public String list(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/index";
        }
        model.addAttribute("userList", userService.listUsers());
        return "user/userList";
    }

    @PostMapping("/status")
    // 切换用户启用/禁用状态。
    // 页面上看到的是按钮，真正的状态修改落在 Service -> Mapper -> 数据库。
    public String status(@RequestParam Integer id, @RequestParam Integer status, HttpSession session) {
        if (isAdmin(session)) {
            userService.changeStatus(id, status);
        }
        return "redirect:/users";
    }

    @PostMapping("/delete")
    // 删除普通用户。
    // 这里同样要先确认当前登录的是管理员，避免普通用户越权。
    public String delete(@RequestParam Integer id, HttpSession session) {
        if (isAdmin(session)) {
            userService.deleteUser(id);
        }
        return "redirect:/users";
    }

    private boolean isAdmin(HttpSession session) {
        // 从 Session 读取当前用户并判断是否为管理员。
        // 判断依据不是用户名，而是数据库里的 role 字段。
        User user = (User) session.getAttribute("loginUser");
        return user != null && "admin".equals(user.getRole());
    }
}
