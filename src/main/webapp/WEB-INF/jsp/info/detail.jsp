<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>公告详情 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 公告详情页：展示单条公告完整内容。 -->
<div class="app">
    <jsp:include page="../common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="../common/topbar.jsp"/><main class="workspace">
        <div class="panel">
            <div class="page-title">
                <div>
                    <h1>${info.title}</h1>
                    <div class="muted">
                        <span class="badge">${info.category}</span>
                        <c:if test="${info.topFlag == 1}"><span class="badge badge-danger">置顶</span></c:if>
                        <span>发布人：${info.publishUser}</span>
                        <span>发布时间：<fmt:formatDate value="${info.publishTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </div>
                </div>
                <a class="btn btn-light" href="${pageContext.request.contextPath}/infos">返回公告列表</a>
            </div>
            <div class="summary public-article">${info.content}</div>
        </div>
    </main>
        
    <jsp:include page="../common/footer.jsp"/>
    </div>
</div>
</body>
</html>


