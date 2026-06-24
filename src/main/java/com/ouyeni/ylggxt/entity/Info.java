package com.ouyeni.ylggxt.entity;

import java.util.Date;

// 公告实体：对应 sys_info 表。
// 这个类描述一条公告的标题、内容、分类、置顶和发布人。
public class Info {
    // 公告主键 ID。
    private Integer id;
    // 公告标题。
    private String title;
    // 公告正文内容。
    private String content;
    // 公告分类，例如门诊通知、健康科普、体检公告等。
    private String category;
    // 是否置顶：1 表示置顶，0 表示普通公告。
    // 这个字段让重要公告排在前面。
    private Integer topFlag;
    // 发布时间，由数据库默认时间或业务层设置。
    private Date publishTime;
    // 发布人账号。
    private String publishUser;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getTopFlag() {
        return topFlag;
    }

    public void setTopFlag(Integer topFlag) {
        this.topFlag = topFlag;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getPublishUser() {
        return publishUser;
    }

    public void setPublishUser(String publishUser) {
        this.publishUser = publishUser;
    }
}
