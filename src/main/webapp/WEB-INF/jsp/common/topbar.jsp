<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 右侧顶部栏：显示系统名称、当前登录用户和项目身份信息。 -->
<div class="topbar">
    <div class="topbar-title">
        <strong>医院挂号叫号系统</strong>
        <span>以预约挂号、候诊叫号为主线，医疗公告作为公共信息入口</span>
    </div>
    <div class="topbar-meta">
        <span class="pill">${sessionScope.loginUser.realname}</span>
        <span>${sessionScope.loginUser.role}</span>
        <span>2406102315_任德斌_医院挂号叫号系统</span>
    </div>
</div>
