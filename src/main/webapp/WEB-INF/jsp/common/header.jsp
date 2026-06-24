<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    /* 公共布局样式：侧边栏 + 顶部栏。 */
    .app {
        min-height: 100vh !important;
        display: grid !important;
        grid-template-columns: 256px minmax(0, 1fr) !important;
        background: #eef3f5 !important;
    }

    .sidebar {
        min-height: 100vh !important;
        display: flex !important;
        flex-direction: column !important;
        gap: 18px !important;
        padding: 24px 18px !important;
        background: linear-gradient(180deg, #10252f, #163241) !important;
        color: #e7f0f4 !important;
        border-right: 1px solid rgba(255,255,255,0.08) !important;
    }

    .brand-block,
    .sidebar-footer {
        padding: 16px !important;
        background: rgba(255,255,255,0.06) !important;
        border: 1px solid rgba(255,255,255,0.10) !important;
        border-radius: 8px !important;
    }

    .brand-title {
        margin: 0 !important;
        color: #ffffff !important;
        font-size: 20px !important;
        line-height: 1.25 !important;
    }

    .brand-subtitle,
    .sidebar-footer {
        color: #c7d8df !important;
        font-size: 13px !important;
        line-height: 1.7 !important;
    }

    .nav-section {
        display: grid !important;
        gap: 8px !important;
    }

    .nav-label {
        margin: 4px 10px 2px !important;
        color: #90a8b6 !important;
        font-size: 12px !important;
        text-transform: uppercase !important;
    }

    .nav-link {
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        gap: 10px !important;
        padding: 12px 14px !important;
        color: #dbe7ec !important;
        text-decoration: none !important;
        border-radius: 6px !important;
        border: 1px solid transparent !important;
    }

    .nav-link:hover {
        background: rgba(255,255,255,0.08) !important;
        border-color: rgba(255,255,255,0.10) !important;
    }

    .sidebar-footer {
        margin-top: auto !important;
    }

    .content {
        min-width: 0 !important;
        display: flex !important;
        flex-direction: column !important;
    }

    .topbar {
        min-height: 70px !important;
        padding: 0 26px !important;
        background: rgba(255,255,255,0.94) !important;
        border-bottom: 1px solid #d9e2e6 !important;
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        gap: 16px !important;
    }

    @media (max-width: 760px) {
        .app {
            grid-template-columns: 1fr !important;
        }

        .sidebar {
            min-height: auto !important;
        }
    }
</style>
<div class="sidebar">
    <!-- 左侧导航：
         admin 能看到“用户管理”和“发布公告”；
         普通用户只看到普通业务入口。
         这里是页面层的分流，后端还会再判断一次，防止直接输地址越权。 -->
    <div class="brand-block">
        <h1 class="brand-title">医院挂号<br>叫号系统</h1>
        <div class="brand-subtitle">SSM 原生架构 · 预约挂号 · 候诊叫号</div>
    </div>

    <div class="nav-section">
        <div class="nav-label">Main</div>
        <a class="nav-link" href="${pageContext.request.contextPath}/index">
            <span>工作台</span><span>01</span>
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/registrations">
            <span>${sessionScope.loginUser.role == 'admin' ? '挂号管理' : '预约挂号'}</span><span>02</span>
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/queue">
            <span>叫号显示</span><span>03</span>
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/infos">
            <span>医疗公告</span><span>04</span>
        </a>
        <c:if test="${sessionScope.loginUser.role == 'admin'}">
            <!-- 只有管理员才显示这些入口。 -->
            <a class="nav-link" href="${pageContext.request.contextPath}/users">
                <span>用户管理</span><span>05</span>
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/infos/add">
                <span>发布公告</span><span>06</span>
            </a>
        </c:if>
    </div>

    <div class="nav-section">
        <div class="nav-label">Account</div>
        <a class="nav-link" href="${pageContext.request.contextPath}/profile">
            <span>个人中心</span><span>ID</span>
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
            <span>退出登录</span><span>OUT</span>
        </a>
    </div>

    <div class="sidebar-footer">
        开发学生：任德斌<br>
        学号：2406102315<br>
        SSM期末综合设计
    </div>
</div>
