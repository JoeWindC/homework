<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>个人中心 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 个人中心：展示当前登录用户和项目信息。 -->
<div class="app">
    <jsp:include page="common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="common/topbar.jsp"/><main class="workspace">
        <div class="page-title">
            <div>
                <h1>个人中心</h1>
                <p>展示当前登录用户与项目身份信息，截图可直接核验学生信息。</p>
            </div>
        </div>
        <div class="profile-grid">
            <div class="panel">
                <h2>${sessionScope.loginUser.realname}</h2>
                <p class="meta">账号：${sessionScope.loginUser.username}</p>
                <p class="meta">角色：${sessionScope.loginUser.role}</p>
                <p class="meta">状态：${sessionScope.loginUser.status == 1 ? '启用' : '禁用'}</p>
            </div>
            <div class="stack">
                <div class="side-item">项目名称：2406102315_任德斌_医院挂号叫号系统</div>
                <div class="side-item">系统名称：医院挂号叫号系统</div>
                <div class="side-item">开发学生：任德斌　学号：2406102315</div>
                <div class="side-item">技术架构：Spring + SpringMVC + MyBatis + JSP + MySQL</div>
            </div>
        </div>
    </main>
        
    <jsp:include page="common/footer.jsp"/>
    </div>
</div>
</body>
</html>


