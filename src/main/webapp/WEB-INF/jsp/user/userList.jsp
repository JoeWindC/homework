<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 用户管理页：管理员启用、禁用和删除用户。 -->
<div class="app">
    <jsp:include page="../common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="../common/topbar.jsp"/><main class="workspace">
        <div class="page-title">
            <div>
                <h1>用户管理</h1>
                <p>管理员可查看用户列表，启用或禁用普通用户，并删除无效普通账号。</p>
            </div>
        </div>
        <div class="panel">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>账号</th>
                    <th>姓名</th>
                    <th>角色</th>
                    <th>状态</th>
                    <th>管理操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userList}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.realname}</td>
                        <td>${user.role}</td>
                        <td>${user.status == 1 ? '启用' : '禁用'}</td>
                        <td>
                            <div class="actions">
                                <c:choose>
                                    <c:when test="${user.role == 'admin'}">
                                        <span class="muted">管理员账号受保护</span>
                                    </c:when>
                                    <c:otherwise>
                                        <form class="inline-form" action="${pageContext.request.contextPath}/users/status" method="post">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <input type="hidden" name="status" value="${user.status == 1 ? 0 : 1}">
                                            <button class="btn btn-warning" type="submit">${user.status == 1 ? '禁用' : '启用'}</button>
                                        </form>
                                        <form class="inline-form" action="${pageContext.request.contextPath}/users/delete" method="post">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button class="btn btn-danger" type="submit">删除</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
        
    <jsp:include page="../common/footer.jsp"/>
    </div>
</div>
</body>
</html>


