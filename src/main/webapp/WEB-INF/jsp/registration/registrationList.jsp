<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${adminView ? '挂号管理' : '我的挂号'} - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 挂号列表页：
     同一个页面里，管理员看“全部预约管理”，普通用户看“我的挂号”。
     你想理解权限怎么分流，就重点看这个页面。 -->
<div class="app">
    <jsp:include page="../common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="../common/topbar.jsp"/><main class="workspace">
        <div class="page-title content-block">
            <div>
                <h1>${adminView ? '挂号管理' : '我的挂号'}</h1>
                <div class="muted">
                    <c:choose>
                        <c:when test="${adminView}">
                            <!-- adminView=true：管理员视角。 -->
                            <span>管理员可查看全部预约挂号记录，并对待处理预约进行确认、完成或取消。</span>
                        </c:when>
                        <c:otherwise>
                            <!-- adminView=false：普通用户视角。 -->
                            <span>普通用户可提交挂号预约，并查看个人预约处理状态。</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <c:if test="${!adminView}">
                <a class="btn" href="${pageContext.request.contextPath}/registrations/add">新增挂号预约</a>
            </c:if>
        </div>

        <c:if test="${not empty msg}">
            <div class="notice success">${msg}</div>
        </c:if>

        <div class="panel">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>就诊人</th>
                    <th>科室/医生</th>
                    <th>预约时间</th>
                    <th>联系电话</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${registrationList}" var="item">
                    <tr>
                        <td>${item.id}</td>
                        <td>
                            <strong>${item.patientName}</strong>
                            <div class="meta">提交账号：${item.username}</div>
                        </td>
                        <td>
                            ${item.department}
                            <div class="meta">${empty item.doctorName ? '普通门诊' : item.doctorName}</div>
                        </td>
                        <td>
                            ${item.visitDate}
                            <div class="meta">${item.timePeriod}</div>
                        </td>
                        <td>${item.phone}</td>
                        <td>
                            <span class="badge ${item.status == '待处理' ? 'badge-warning' : item.status == '已确认' ? 'badge-blue' : item.status == '已取消' ? 'badge-danger' : 'badge-success'}">${item.status}</span>
                        </td>
                        <td>
                            <div class="actions">
                                <c:choose>
                                    <c:when test="${adminView}">
                                        <!-- 管理员能看到状态修改按钮，是因为后端已经确认 role=admin。 -->
                                        <c:choose>
                                            <c:when test="${item.status == '待处理'}">
                                                <form class="inline-form" action="${pageContext.request.contextPath}/registrations/status" method="post">
                                                    <input type="hidden" name="id" value="${item.id}">
                                                    <input type="hidden" name="status" value="已确认">
                                                    <button class="btn btn-light" type="submit">确认</button>
                                                </form>
                                                <form class="inline-form" action="${pageContext.request.contextPath}/registrations/status" method="post">
                                                    <input type="hidden" name="id" value="${item.id}">
                                                    <input type="hidden" name="status" value="已取消">
                                                    <button class="btn btn-danger" type="submit">取消</button>
                                                </form>
                                            </c:when>
                                            <c:when test="${item.status == '已确认'}">
                                                <form class="inline-form" action="${pageContext.request.contextPath}/registrations/status" method="post">
                                                    <input type="hidden" name="id" value="${item.id}">
                                                    <input type="hidden" name="status" value="已完成">
                                                    <button class="btn" type="submit">完成</button>
                                                </form>
                                                <form class="inline-form" action="${pageContext.request.contextPath}/registrations/status" method="post">
                                                    <input type="hidden" name="id" value="${item.id}">
                                                    <input type="hidden" name="status" value="已取消">
                                                    <button class="btn btn-danger" type="submit">取消</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="muted">已结束</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 普通用户只能撤销自己的待处理预约。 -->
                                        <c:if test="${item.status == '待处理'}">
                                            <form class="inline-form" action="${pageContext.request.contextPath}/registrations/cancel" method="post">
                                                <input type="hidden" name="id" value="${item.id}">
                                                <button class="btn btn-danger" type="submit">撤销</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${item.status != '待处理'}">
                                            <span class="muted">无需操作</span>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                    <c:if test="${not empty item.remark}">
                        <tr class="sub-row">
                            <td></td>
                            <td colspan="6">病情说明：${item.remark}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${empty registrationList}">
                    <tr>
                        <td colspan="7">暂无挂号预约记录。</td>
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


