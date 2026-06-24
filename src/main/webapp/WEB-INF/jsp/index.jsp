<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>工作台 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=7">
</head>
<body>
<!-- 首页工作台：
     这是登录后的总入口，先看这个页面就知道系统有哪些功能块。 -->
<div class="app">
    <jsp:include page="common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="common/topbar.jsp"/><main class="workspace dashboard-home">
        <div class="home-hero">
            <div class="home-hero-main">
                <span class="eyebrow">Hospital Registration Queue System</span>
                <h1>医院挂号叫号工作台</h1>
                <p>
                    系统以预约挂号和候诊叫号为主线：普通用户登录后提交挂号预约，管理员确认预约并维护就诊状态；
                    医疗公告作为公共信息入口，未登录患者也可以查看门诊通知和健康提醒。
                </p>
                <div class="actions">
                    <a class="btn" href="${pageContext.request.contextPath}/registrations">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.role == 'admin'}">处理挂号预约</c:when>
                            <c:otherwise>预约挂号</c:otherwise>
                        </c:choose>
                    </a>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/queue">查看叫号屏</a>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/infos">医疗公告</a>
                </div>
            </div>
            <div class="home-hero-visual">
                <img src="${pageContext.request.contextPath}/static/images/banner-registration.png" alt="预约挂号">
                <div class="visual-note">
                    <strong>今日门诊</strong>
                    <span>预约处理、候诊叫号、公告通知统一查看</span>
                </div>
            </div>
        </div>

        <div class="metrics-row">
            <div class="metric-card accent">
                <span>挂号预约</span>
                <strong>${empty registrationCount ? 0 : registrationCount}</strong>
                <em>累计预约记录</em>
            </div>
            <div class="metric-card">
                <span>待处理预约</span>
                <strong>${empty pendingRegistrationCount ? 0 : pendingRegistrationCount}</strong>
                <em>需要管理员确认</em>
            </div>
            <div class="metric-card">
                <span>医疗公告</span>
                <strong>${empty infoCount ? 0 : infoCount}</strong>
                <em>公开发布内容</em>
            </div>
            <div class="metric-card">
                <span>系统用户</span>
                <strong>${empty userCount ? 0 : userCount}</strong>
                <em>注册使用人员</em>
            </div>
            <div class="metric-card">
                <span>启用用户</span>
                <strong>${empty enabledUserCount ? 0 : enabledUserCount}</strong>
                <em>当前可登录账号</em>
            </div>
        </div>

        <div class="workbench-grid">
            <div class="panel feature-panel">
                <div class="section-head compact">
                    <div>
                        <h2>最新医疗公告</h2>
                        <p class="muted">公告面向所有患者公开浏览，登录只用于预约挂号和个人记录查询</p>
                    </div>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/infos">查看全部</a>
                </div>
                <div class="notice-list">
                    <c:forEach items="${infoList}" var="info" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <a class="notice-row" href="${pageContext.request.contextPath}/infos/${info.id}">
                                <div class="notice-row-main">
                                    <h3>${info.title}</h3>
                                    <div class="notice-row-meta">
                                        <span class="badge">${info.category}</span>
                                        <c:if test="${info.topFlag == 1}">
                                            <span class="badge badge-danger">置顶</span>
                                        </c:if>
                                        <span>发布人：${info.publishUser}</span>
                                    </div>
                                </div>
                                <time><fmt:formatDate value="${info.publishTime}" pattern="MM-dd HH:mm"/></time>
                            </a>
                        </c:if>
                    </c:forEach>
                    <c:if test="${empty infoList}">
                        <div class="empty-state">
                            <strong>暂无公告</strong>
                            <span>管理员可以先发布门诊通知、体检公告或健康科普内容。</span>
                            <c:if test="${sessionScope.loginUser.role == 'admin'}">
                                <a class="btn btn-warning" href="${pageContext.request.contextPath}/infos/add">立即发布</a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

    </main>
        
    <jsp:include page="common/footer.jsp"/>
    </div>
</div>
</body>
</html>


