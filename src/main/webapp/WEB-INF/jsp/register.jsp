<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>注册 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 注册页：普通用户创建账号。 -->
<main class="auth-page">
    <div class="auth-shell">
        <div class="auth-hero">
            <h1>普通用户注册</h1>
            <p>注册后可登录系统浏览医疗公告。系统会检查账号非空和账号唯一性，注册账号默认为普通用户权限。</p>
        </div>
        <div class="auth-card">
            <h2>填写注册信息</h2>
            <c:if test="${not empty error}">
                <div class="notice">${error}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="field">
                    <label for="username">账号</label>
                    <input id="username" name="username" required placeholder="账号不能为空">
                </div>
                <div class="field">
                    <label for="password">密码</label>
                    <input id="password" name="password" type="password" required placeholder="密码不能为空">
                </div>
                <div class="field">
                    <label for="realname">真实姓名</label>
                    <input id="realname" name="realname" required placeholder="请输入真实姓名">
                </div>
                <div class="field actions">
                    <button class="btn" type="submit">提交注册</button>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/login">返回登录</a>
                </div>
            </form>
        </div>
    </div>
</main>
<div class="footer-id">
    开发学生：任德斌 &nbsp;&nbsp; 学号：2406102315 &nbsp;&nbsp; SSM期末综合设计
</div>
</body>
</html>

