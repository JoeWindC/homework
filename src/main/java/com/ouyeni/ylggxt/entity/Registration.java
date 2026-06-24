package com.ouyeni.ylggxt.entity;

import java.util.Date;

// 挂号预约实体：对应 sys_registration 表。
// 这个类描述一次挂号预约从提交到处理的完整信息。
public class Registration {
    // 挂号预约主键 ID。
    private Integer id;
    // 预约所属用户 ID，对应 sys_user.id。
    // 用它就能知道这条预约是谁提交的。
    private Integer userId;
    // 预约用户账号，联表查询时展示。
    private String username;
    // 预约用户真实姓名，联表查询时展示。
    private String realname;
    // 就诊科室。
    private String department;
    // 医生姓名，可为空。
    private String doctorName;
    // 预约日期。
    private String visitDate;
    // 预约时段。
    private String timePeriod;
    // 就诊人姓名。
    private String patientName;
    // 联系电话。
    private String phone;
    // 病情说明或备注。
    private String remark;
    // 预约状态，例如待处理、已确认、已完成、已取消。
    // 这个字段决定普通用户能不能取消，也决定管理员能怎么处理。
    private String status;
    // 创建时间。
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(String visitDate) {
        this.visitDate = visitDate;
    }

    public String getTimePeriod() {
        return timePeriod;
    }

    public void setTimePeriod(String timePeriod) {
        this.timePeriod = timePeriod;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
