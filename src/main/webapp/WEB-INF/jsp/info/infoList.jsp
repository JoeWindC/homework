<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>医疗信息公告 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 公告列表页：
     公告所有人可看，维护按钮只给管理员。
     前端隐藏按钮只是展示层，后端还会再校验一次角色。 -->
<div class="app">
    <jsp:include page="../common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="../common/topbar.jsp"/><main class="workspace">
        <div class="page-title content-block">
            <div>
                <h1>医疗信息公告</h1>
                <div class="muted">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.role == 'admin'}">
                            <!-- 管理员能发布、编辑、删除公告。 -->
                            <span>管理员可以发布、编辑、删除公告；公告列表是后台维护的重要内容之一。</span>
                        </c:when>
                        <c:otherwise>
                            <!-- 普通用户只能浏览。 -->
                            <span>普通用户可以查看公告详情，但不能进行公告维护操作。</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <c:if test="${sessionScope.loginUser.role == 'admin'}">
                <!-- 只有管理员才显示“发布医疗公告”。 -->
                <a class="btn" href="${pageContext.request.contextPath}/infos/add">发布医疗公告</a>
            </c:if>
        </div>

        <div class="toolbar">
            <form action="${pageContext.request.contextPath}/infos" method="get" class="actions">
                <input name="keyword" value="${keyword}" placeholder="搜索标题、内容或发布人" style="max-width:360px;">
                <select name="category" style="max-width:180px;">
                    <option value="">全部分类</option>
                    <option value="门诊通知" ${category == '门诊通知' ? 'selected' : ''}>门诊通知</option>
                    <option value="急诊提醒" ${category == '急诊提醒' ? 'selected' : ''}>急诊提醒</option>
                    <option value="体检公告" ${category == '体检公告' ? 'selected' : ''}>体检公告</option>
                    <option value="健康科普" ${category == '健康科普' ? 'selected' : ''}>健康科普</option>
                    <option value="药房通知" ${category == '药房通知' ? 'selected' : ''}>药房通知</option>
                </select>
                <button class="btn" type="submit">搜索</button>
                <a class="btn btn-light" href="${pageContext.request.contextPath}/infos">重置</a>
            </form>
            <span class="muted">共 ${infoList.size()} 条记录</span>
        </div>

        <div class="panel">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>公告标题</th>
                    <th>分类</th>
                    <th>发布人</th>
                    <th>发布时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${infoList}" var="info">
                    <tr>
                        <td>${info.id}</td>
                        <td>
                            <c:if test="${info.topFlag == 1}">
                                <span class="badge badge-danger">置顶</span>
                            </c:if>
                            ${info.title}
                        </td>
                        <td><span class="badge">${info.category}</span></td>
                        <td>${info.publishUser}</td>
                        <td><fmt:formatDate value="${info.publishTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <div class="actions">
                                <a class="btn btn-light" href="${pageContext.request.contextPath}/infos/${info.id}">查看</a>
                                <c:if test="${sessionScope.loginUser.role == 'admin'}">
                                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/infos/edit/${info.id}">编辑</a>
                                    <form class="inline-form" action="${pageContext.request.contextPath}/infos/delete" method="post">
                                        <input type="hidden" name="id" value="${info.id}">
                                        <button class="btn btn-danger" type="submit">删除</button>
                                    </form>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty infoList}">
                    <tr>
                        <td colspan="6">暂无匹配公告。</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
        
    <jsp:include page="../common/footer.jsp"/>
    </div>
</div>
</body>
</html>


