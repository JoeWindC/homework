package com.ouyeni.ylggxt.service;

import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

// 启动日志组件：Spring 容器初始化后输出学生身份信息。
@Component
public class StartupLogger {
    @PostConstruct
    // 在容器启动完成后打印项目身份信息，方便课堂截图核验。
    public void printStudentInfo() {
        System.out.println("===== 项目启动成功｜学生：任德斌 学号：2406102315 =====");
    }
}
