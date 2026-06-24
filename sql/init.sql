-- 初始化脚本：创建数据库、建表并插入默认测试数据。
CREATE DATABASE IF NOT EXISTS db_2406102315_rdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_2406102315_rdb;

DROP TABLE IF EXISTS sys_info;
DROP TABLE IF EXISTS sys_registration;
DROP TABLE IF EXISTS sys_user;

CREATE TABLE sys_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE COMMENT '登录账号',
    password VARCHAR(30) NOT NULL COMMENT '登录密码',
    realname VARCHAR(20) NOT NULL COMMENT '真实姓名',
    role VARCHAR(10) NOT NULL COMMENT '角色：admin/user',
    status TINYINT DEFAULT 1 COMMENT '账号状态1启用0禁用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表-2406102315-RDB';

CREATE TABLE sys_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL COMMENT '医疗公告标题',
    content TEXT NOT NULL COMMENT '医疗公告内容',
    category VARCHAR(20) NOT NULL DEFAULT '门诊通知' COMMENT '公告分类',
    top_flag TINYINT DEFAULT 0 COMMENT '是否置顶',
    publish_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    publish_user VARCHAR(30) NOT NULL COMMENT '发布人账号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医疗公告表-2406102315-RDB';

CREATE TABLE sys_registration (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL COMMENT '预约用户ID',
    department VARCHAR(20) NOT NULL COMMENT '就诊科室',
    doctor_name VARCHAR(30) DEFAULT NULL COMMENT '医生姓名',
    visit_date DATE NOT NULL COMMENT '预约日期',
    time_period VARCHAR(30) NOT NULL COMMENT '预约时段',
    patient_name VARCHAR(20) NOT NULL COMMENT '就诊人姓名',
    phone VARCHAR(20) NOT NULL COMMENT '联系电话',
    remark VARCHAR(255) DEFAULT NULL COMMENT '病情说明',
    status VARCHAR(10) NOT NULL DEFAULT '待处理' COMMENT '状态',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    CONSTRAINT fk_registration_user FOREIGN KEY (user_id) REFERENCES sys_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='挂号预约表-2406102315-RDB';

INSERT INTO sys_user (username, password, realname, role, status)
VALUES ('admin', '123456', 'RDB管理员', 'admin', 1),
       ('user', '123456', 'RDB普通用户', 'user', 1);

INSERT INTO sys_info (title, content, category, top_flag, publish_user)
VALUES ('门诊时间调整通知', '为方便师生及社区居民就诊，本周六上午内科门诊正常开放，请提前安排就诊时间。', '门诊通知', 1, 'admin'),
       ('春季健康科普公告', '近期气温变化明显，请注意规律作息、合理饮食，出现发热咳嗽等症状请及时就医。', '健康科普', 0, 'admin'),
       ('体检中心预约提醒', '体检中心工作日8:00-11:30开放预约登记，请携带身份证件并保持空腹。', '体检公告', 0, 'admin'),
       ('急诊绿色通道说明', '急诊绿色通道面向胸痛、卒中、严重外伤等急危重症患者开放，请按现场医护人员指引就诊。', '急诊提醒', 1, 'admin'),
       ('药房取药窗口调整', '门诊药房新增2号取药窗口，慢病复诊患者可根据叫号屏提示有序取药。', '药房通知', 0, 'admin');

INSERT INTO sys_registration (user_id, department, doctor_name, visit_date, time_period, patient_name, phone, remark, status)
VALUES (2, '内科', '普通门诊', '2026-06-20', '上午 08:00-11:30', 'RDB', '13800000000', '咳嗽发热两天', '待处理'),
       (2, '体检中心', NULL, '2026-06-22', '上午 08:00-11:30', 'RDB', '13800000000', '年度体检预约', '已确认');
