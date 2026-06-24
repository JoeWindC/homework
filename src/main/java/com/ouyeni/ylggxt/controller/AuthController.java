package com.ouyeni.ylggxt.controller;

import com.ouyeni.ylggxt.entity.User;
import com.ouyeni.ylggxt.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
// 认证控制器：
// 这里只处理“进系统之前”的动作，核心职责就是登录、注册、退出。
// 登录成功后会把用户对象放进 Session，后面所有权限判断都靠它。
public class AuthController {
    @Resource
    private UserService userService;

    @GetMapping("/login")
    // 打开登录页，并把提示信息带到页面上。
    // 这里不做业务处理，只负责把前端要展示的 msg 传给 JSP。
    public String loginPage(@RequestParam(value = "msg", required = false) String msg, Model model) {
        model.addAttribute("msg", msg);
        return "login";
    }

    @PostMapping("/login")
    // 处理登录提交：
    // 1. 去数据库查账号和密码
    // 2. 检查账号是否启用
    // 3. 登录成功后把 user 放进 Session
    // 后面页面和控制器会根据这个 Session 判断你是谁。
    // 这一步是整个项目权限体系的起点。
    public String login(String username, String password, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = userService.login(username, password);
        if (user == null) {
            redirectAttributes.addAttribute("msg", "账号或密码错误，或账号已被禁用");
            return "redirect:/login";
        }
        // 登录成功后把当前用户对象放进 Session。
        // 后续 header.jsp、拦截器、各个 Controller 都会从这里读取 loginUser。
        session.setAttribute("loginUser", user);
        return "redirect:/index";
    }

    @GetMapping("/register")
    // 打开注册页。
    // 普通用户从这里注册，注册结果最终还是由后端 Service 决定。
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    // 处理注册提交：
    // 这里是普通用户注册入口，后端会强制写成 user 角色，不能自己注册成管理员。
    // 也就是说：前端表单只负责提交，真正的角色赋值由服务层控制。
    public String register(User user, RedirectAttributes redirectAttributes) {
        String error = userService.register(user);
        if (error != null) {
            redirectAttributes.addFlashAttribute("error", error);
            return "redirect:/register";
        }
        redirectAttributes.addAttribute("msg", "注册成功，请登录");
        return "redirect:/login";
    }

    @GetMapping("/logout")
    // 退出登录：清空 Session，当前登录态立即失效。
    // 清空 Session 之后，LoginInterceptor 会把用户重新拦回登录页。
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addAttribute("msg", "已安全退出");
        return "redirect:/login";
    }
}
