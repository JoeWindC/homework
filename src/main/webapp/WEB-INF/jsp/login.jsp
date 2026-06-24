<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 登录页：
     这是权限分流的起点。
     登录成功后，后面所有页面都靠 sessionScope.loginUser 判断身份。 -->
<main class="auth-page">
    <div class="auth-shell">
        <div class="auth-hero">
            <div class="auth-mark">Hospital Registration Queue System</div>
            <h1>医院挂号<br>叫号系统</h1>
            <p>登录后使用预约挂号、挂号管理、用户管理和公告维护等功能，系统采用严格的登录校验与权限控制。</p>
            <div class="quick-panel">
                <!-- 先看这三块：管理员、普通用户、权限控制。 -->
                <div class="quick-item"><strong>管理员</strong><span>确认挂号、更新状态、维护公告和用户账号。</span></div>
                <div class="quick-item"><strong>普通用户</strong><span>登录后提交预约，并查看自己的挂号处理进度。</span></div>
                <div class="quick-item"><strong>权限控制</strong><span>未登录无法访问业务页面，统一由拦截器拦截。</span></div>
            </div>
            <div class="auth-stats">
                <span>SSM 原生架构</span>
                <span>MySQL 8</span>
                <span>Tomcat 9</span>
            </div>
        </div>
        <div class="auth-card">
            <h2>账号登录</h2>
            <p class="auth-card-tip">预约挂号、查看个人预约记录、公告管理都需要登录后才能使用。</p>
            <c:if test="${not empty msg}">
                <div class="notice">${msg}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="field">
                    <label for="username">账号</label>
                    <input id="username" name="username" required placeholder="请输入账号">
                </div>
                <div class="field">
                    <label for="password">密码</label>
                    <input id="password" name="password" type="password" required placeholder="请输入密码">
                </div>
                <div class="field actions">
                    <button class="btn" type="submit">进入系统</button>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/register">注册普通用户</a>
                </div>
            </form>
            <div class="login-meta">
                <div class="login-meta-item">
                    <span>管理员</span>
                    <strong>admin / 123456</strong>
                </div>
                <div class="login-meta-item">
                    <span>普通用户</span>
                    <strong>user / 123456</strong>
                </div>
            </div>
        </div>
    </div>
</main>
<div class="footer-id">
    开发学生：任德斌 &nbsp;&nbsp; 学号：2406102315 &nbsp;&nbsp; SSM期末综合设计
</div>
</body>
</html>

