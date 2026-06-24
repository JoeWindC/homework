package com.ouyeni.ylggxt.interceptor;

import com.ouyeni.ylggxt.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 登录拦截器：
// 它只管“有没有登录”，不管“是不是管理员”。
// 是否管理员由具体 Controller 和 JSP 再判断。
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    // 在控制器执行前检查 Session 是否已有 loginUser。
    // 没有登录用户就说明还没进系统，直接踢回登录页。
    // 这个拦截器是整个系统的第一道门，防止未登录的人直接敲业务地址。
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        if (loginUser != null) {
            return true;
        }
        response.sendRedirect(request.getContextPath() + "/login?msg=请先登录后再访问系统");
        return false;
    }
}
