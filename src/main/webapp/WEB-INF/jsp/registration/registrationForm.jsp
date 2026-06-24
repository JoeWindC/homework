<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>预约挂号 - 医院挂号叫号系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css?v=2">
</head>
<body>
<!-- 挂号表单页：普通用户提交预约信息。 -->
<div class="app">
    <jsp:include page="../common/header.jsp"/>
    
    <div class="content">
        <jsp:include page="../common/topbar.jsp"/><main class="workspace">
        <div class="page-title">
            <div>
                <h1>预约挂号</h1>
                <p>请按实际就诊需求填写预约信息，提交后由管理员进行确认处理。</p>
            </div>
            <a class="btn btn-light" href="${pageContext.request.contextPath}/registrations">返回我的挂号</a>
        </div>

        <div class="panel">
            <c:if test="${not empty error}">
                <div class="notice warning">${error}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/registrations/add" method="post">
                <div class="form-grid">
                    <div class="field">
                        <label for="department">就诊科室</label>
                        <select id="department" name="department" required>
                            <option value="">请选择科室</option>
                            <option value="内科">内科</option>
                            <option value="外科">外科</option>
                            <option value="儿科">儿科</option>
                            <option value="口腔科">口腔科</option>
                            <option value="体检中心">体检中心</option>
                            <option value="急诊科">急诊科</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="doctorName">医生姓名</label>
                        <input id="doctorName" name="doctorName" placeholder="可填写指定医生，也可填写普通门诊">
                    </div>
                    <div class="field">
                        <label for="visitDate">就诊日期</label>
                        <input id="visitDate" name="visitDate" type="date" required>
                    </div>
                    <div class="field">
                        <label for="timePeriod">就诊时段</label>
                        <select id="timePeriod" name="timePeriod" required>
                            <option value="">请选择时段</option>
                            <option value="上午 08:00-11:30">上午 08:00-11:30</option>
                            <option value="下午 14:00-17:00">下午 14:00-17:00</option>
                            <option value="夜间 18:00-20:00">夜间 18:00-20:00</option>
                        </select>
                    </div>
                    <div class="field">
                        <label for="patientName">就诊人姓名</label>
                        <input id="patientName" name="patientName" required placeholder="请输入就诊人姓名">
                    </div>
                    <div class="field">
                        <label for="phone">联系电话</label>
                        <input id="phone" name="phone" required placeholder="请输入联系电话">
                    </div>
                </div>
                <div class="field">
                    <label for="remark">病情说明</label>
                    <textarea id="remark" name="remark" placeholder="可简单说明症状、复诊需求或特殊情况"></textarea>
                </div>
                <div class="field actions">
                    <button class="btn" type="submit">提交挂号预约</button>
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/registrations">取消返回</a>
                </div>
            </form>
        </div>
    </main>
        
    <jsp:include page="../common/footer.jsp"/>
    </div>
</div>
</body>
</html>


