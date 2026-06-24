<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>公告维护 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 公告表单页：用于新增和编辑公告。 -->
<div class="app">
    <jsp:include page="../common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="../common/topbar.jsp"/><main class="workspace">
        <div class="page-title">
            <div>
                <h1>${empty info ? '发布医疗公告' : '编辑医疗公告'}</h1>
                <p>公告内容会面向普通用户展示，请填写清晰、准确的医疗服务信息。</p>
            </div>
        </div>
        <div class="panel">
            <form action="${pageContext.request.contextPath}/infos/${empty info ? 'add' : 'edit'}" method="post">
                <c:if test="${not empty info}">
                    <input type="hidden" name="id" value="${info.id}">
                </c:if>
                <div class="field">
                    <label for="title">公告标题</label>
                    <input id="title" name="title" value="${info.title}" required placeholder="例如：门诊时间调整通知">
                </div>
                <div class="form-grid">
                    <div class="field">
                        <label for="category">公告分类</label>
                        <select id="category" name="category" required>
                            <option value="门诊通知" ${info.category == '门诊通知' ? 'selected' : ''}>门诊通知</option>
                            <option value="急诊提醒" ${info.category == '急诊提醒' ? 'selected' : ''}>急诊提醒</option>
                            <option value="体检公告" ${info.category == '体检公告' ? 'selected' : ''}>体检公告</option>
                            <option value="健康科普" ${info.category == '健康科普' ? 'selected' : ''}>健康科普</option>
                            <option value="药房通知" ${info.category == '药房通知' ? 'selected' : ''}>药房通知</option>
                        </select>
                    </div>
                    <div class="field">
                        <label>公告级别</label>
                        <label class="check-line">
                            <input type="checkbox" name="topFlag" value="1" ${info.topFlag == 1 ? 'checked' : ''}>
                            设为置顶/重要公告
                        </label>
                    </div>
                </div>
                <div class="field">
                    <label for="content">公告内容</label>
                    <textarea id="content" name="content" required placeholder="请输入公告正文">${info.content}</textarea>
                </div>
                <div class="field actions">
                    <button class="btn" type="submit">保存公告</button>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/infos">取消返回</a>
                </div>
            </form>
        </div>
    </main>
        
    <jsp:include page="../common/footer.jsp"/>
    </div>
</div>
</body>
</html>


