package com.ouyeni.ylggxt.entity;

// 用户实体：对应 sys_user 表。
// 这个类承载登录账号、密码、姓名、角色和状态，是整个权限系统的基础。
public class User {
    // 用户主键 ID，对应 sys_user.id。
    private Integer id;
    // 登录账号，要求唯一。
    private String username;
    // 登录密码，示例项目中按明文保存。
    private String password;
    // 用户真实姓名，用于页面展示。
    private String realname;
    // 用户角色：admin 表示管理员，user 表示普通用户。
    // 这个字段是后端判断“谁能进管理员面板”的核心依据。
    private String role;
    // 账号状态：1 启用，0 禁用。
    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
