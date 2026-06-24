package com.ouyeni.ylggxt.controller;

import com.ouyeni.ylggxt.entity.Registration;
import com.ouyeni.ylggxt.entity.User;
import com.ouyeni.ylggxt.service.RegistrationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/registrations")
// 挂号预约控制器：
// 同一个 URL，管理员看到“全部预约管理”，普通用户看到“我的挂号”。
public class RegistrationController {
    @Resource
    private RegistrationService registrationService;

    @GetMapping
    // 挂号列表页：
    // adminView=true -> 管理员视角
    // adminView=false -> 普通用户视角
    // 这里把“同一个页面不同角色看到不同内容”做成了一个清晰的分流点。
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (isAdmin(user)) {
            model.addAttribute("registrationList", registrationService.listAll());
            model.addAttribute("adminView", true);
        } else {
            model.addAttribute("registrationList", registrationService.listMine(user.getId()));
            model.addAttribute("adminView", false);
        }
        return "registration/registrationList";
    }

    @GetMapping("/add")
    // 新增挂号预约页面。
    public String addPage() {
        return "registration/registrationForm";
    }

    @PostMapping("/add")
    // 提交挂号预约，并自动绑定当前登录用户。
    // 这里不信任前端传来的 userId，后端自己从 Session 里拿。
    // 这样普通用户就不能伪造别人的 userId。
    public String add(Registration registration, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loginUser");
        registration.setUserId(user.getId());
        String result = registrationService.save(registration);
        if (!"success".equals(result)) {
            redirectAttributes.addFlashAttribute("error", result);
            return "redirect:/registrations/add";
        }
        redirectAttributes.addFlashAttribute("msg", "挂号预约已提交，请等待管理员确认");
        return "redirect:/registrations";
    }

    @PostMapping("/status")
    // 管理员修改预约状态。
    // 只有管理员可以把“待处理”改成“已确认/已完成/已取消”。
    public String status(@RequestParam Integer id, @RequestParam String status, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (isAdmin(user)) {
            registrationService.changeStatus(id, status);
        }
        return "redirect:/registrations";
    }

    @PostMapping("/cancel")
    // 普通用户取消自己的待处理预约。
    // 后端还会在 SQL 层再检查 userId 和状态，双重防护更稳。
    public String cancel(@RequestParam Integer id, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (!isAdmin(user)) {
            registrationService.cancel(id, user.getId());
        }
        return "redirect:/registrations";
    }

    private boolean isAdmin(User user) {
        // 统一判断是否管理员。
        // 规则很简单：loginUser 存在且 role == admin。
        return user != null && "admin".equals(user.getRole());
    }
}
