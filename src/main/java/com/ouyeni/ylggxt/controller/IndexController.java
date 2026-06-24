package com.ouyeni.ylggxt.controller;

import com.ouyeni.ylggxt.service.InfoService;
import com.ouyeni.ylggxt.service.RegistrationService;
import com.ouyeni.ylggxt.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;

@Controller
// 首页与工作台控制器：负责首页统计、个人中心和叫号页面。
public class IndexController {
    @Resource
    private InfoService infoService;
    @Resource
    private UserService userService;
    @Resource
    private RegistrationService registrationService;

    @GetMapping("/")
    // 根路径直接跳转登录页。
    // 这样用户打开项目首页时会先进入登录流程。
    public String root() {
        return "redirect:/login";
    }

    @GetMapping("/index")
    // 首页工作台：装配公告、用户和预约统计数据。
    // 首页不是静态页，而是一个集中展示系统状态的工作台。
    public String index(Model model) {
        model.addAttribute("infoList", infoService.listInfos());
        model.addAttribute("infoCount", infoService.countInfos());
        model.addAttribute("userCount", userService.countUsers());
        model.addAttribute("enabledUserCount", userService.countEnabledUsers());
        model.addAttribute("registrationCount", registrationService.countAll());
        model.addAttribute("pendingRegistrationCount", registrationService.countPending());
        return "index";
    }

    @GetMapping("/profile")
    // 个人中心页面。
    // 这个页面通常显示当前登录用户的信息。
    public String profile() {
        return "profile";
    }

    @GetMapping("/queue")
    // 叫号展示页面：用于公开查看预约队列。
    // 这里展示的是待处理和已确认预约，方便门诊叫号。
    public String queue(Model model) {
        model.addAttribute("queueList", registrationService.listQueue());
        model.addAttribute("pendingRegistrationCount", registrationService.countPending());
        return "queue";
    }
}
