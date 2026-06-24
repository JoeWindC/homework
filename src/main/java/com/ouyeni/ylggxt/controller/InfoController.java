package com.ouyeni.ylggxt.controller;

import com.ouyeni.ylggxt.entity.Info;
import com.ouyeni.ylggxt.entity.User;
import com.ouyeni.ylggxt.service.InfoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/infos")
// 医疗公告控制器：
// 公告列表和详情人人都能看，维护功能只给管理员。
public class InfoController {
    @Resource
    private InfoService infoService;

    @GetMapping
    // 公告列表页，支持关键字和分类查询。
    // 这里是普通用户和管理员都能进入的公共公告入口。
    public String list(@RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "category", required = false) String category,
                       Model model) {
        model.addAttribute("infoList", infoService.searchInfos(keyword, category));
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        return "info/infoList";
    }

    @GetMapping("/{id}")
    // 公告详情页。
    // 详情页是纯展示，不涉及写库操作，所以所有登录用户都可以看。
    public String detail(@PathVariable Integer id, Model model) {
        model.addAttribute("info", infoService.getInfo(id));
        return "info/detail";
    }

    @GetMapping("/add")
    // 新增公告页面，仅管理员可进入。
    // 这里先挡一次，前端即使直接敲地址也进不来。
    public String addPage(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/infos";
        }
        return "info/infoForm";
    }

    @PostMapping("/add")
    // 提交新增公告，自动绑定当前登录管理员账号。
    // 发布人不从前端输入，直接用当前登录账号写入。
    // 这样公告的发布人是可信的，不会被伪造。
    public String add(Info info, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (isAdmin(session)) {
            info.setPublishUser(loginUser.getUsername());
            infoService.saveInfo(info);
        }
        return "redirect:/infos";
    }

    @GetMapping("/edit/{id}")
    // 编辑公告页面。
    // 编辑前先确认管理员身份，再把公告原数据回填到表单。
    public String editPage(@PathVariable Integer id, Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/infos";
        }
        model.addAttribute("info", infoService.getInfo(id));
        return "info/infoForm";
    }

    @PostMapping("/edit")
    // 保存公告修改。
    // 页面提交过来的是修改后的公告数据，真正落库在 Service 层完成。
    public String edit(Info info, HttpSession session) {
        if (isAdmin(session)) {
            infoService.updateInfo(info);
        }
        return "redirect:/infos";
    }

    @PostMapping("/delete")
    // 删除公告。
    // 删除公告也是管理员动作，普通用户直接访问会被忽略。
    public String delete(Integer id, HttpSession session) {
        if (isAdmin(session)) {
            infoService.deleteInfo(id);
        }
        return "redirect:/infos";
    }

    private boolean isAdmin(HttpSession session) {
        // 只有 Session 里是 admin，才算管理员。
        // 这和 header.jsp 里的页面展示判断是一致的。
        User user = (User) session.getAttribute("loginUser");
        return user != null && "admin".equals(user.getRole());
    }
}
