<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>门诊叫号显示 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 叫号展示页：公开显示预约队列。 -->
<div class="app">
    <jsp:include page="common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="common/topbar.jsp"/><main class="workspace">
        <div class="page-title content-block">
            <div>
                <h1>门诊叫号显示</h1>
                <p>本页用于展示当前待处理和已确认的挂号预约，方便管理员在工作台中掌握候诊进度。</p>
            </div>
        </div>

        <div class="panel">
            <div class="queue-summary-inline">
                <span>待处理预约</span>
                <strong>${empty pendingRegistrationCount ? 0 : pendingRegistrationCount}</strong>
            </div>
        </div>

        <div class="queue-board">
            <div class="queue-board-head">
                <div>序号</div>
                <div>就诊人</div>
                <div>科室/医生</div>
                <div>预约时段</div>
                <div>状态</div>
            </div>
            <c:forEach items="${queueList}" var="item" varStatus="status">
                <div class="queue-row ${item.status == '已确认' ? 'queue-current' : ''}">
                    <div class="queue-no">${status.index + 1}</div>
                    <div>
                        <strong>${item.patientName}</strong>
                        <span>预约号：${item.id}</span>
                    </div>
                    <div>
                        <strong>${item.department}</strong>
                        <span>${empty item.doctorName ? '普通门诊' : item.doctorName}</span>
                    </div>
                    <div>
                        <strong>${item.visitDate}</strong>
                        <span>${item.timePeriod}</span>
                    </div>
                    <div>
                        <span class="badge ${item.status == '已确认' ? 'badge-blue' : 'badge-warning'}">${item.status}</span>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty queueList}">
                <div class="queue-empty">
                    <strong>暂无候诊记录</strong>
                    <span>当前没有已确认或待处理的挂号预约。</span>
                </div>
            </c:if>
        </div>
    </main>
        
    <jsp:include page="common/footer.jsp"/>
    </div>
</div>
</body>
</html>


