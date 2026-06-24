USE db_2406102315_rdb;

ALTER TABLE sys_info
    ADD COLUMN category VARCHAR(20) NOT NULL DEFAULT '门诊通知' COMMENT '公告分类',
    ADD COLUMN top_flag TINYINT DEFAULT 0 COMMENT '是否置顶';

UPDATE sys_info
SET category = CASE
    WHEN title LIKE '%急诊%' THEN '急诊提醒'
    WHEN title LIKE '%体检%' THEN '体检公告'
    WHEN title LIKE '%健康%' THEN '健康科普'
    WHEN title LIKE '%药房%' THEN '药房通知'
    ELSE '门诊通知'
END,
top_flag = CASE
    WHEN title LIKE '%急诊%' OR title LIKE '%门诊时间%' THEN 1
    ELSE 0
END;

CREATE TABLE IF NOT EXISTS sys_registration (
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

INSERT INTO sys_registration (user_id, department, doctor_name, visit_date, time_period, patient_name, phone, remark, status)
SELECT id, '内科', '普通门诊', '2026-06-20', '上午 08:00-11:30', realname, '13800000000', '咳嗽发热两天', '待处理'
FROM sys_user
WHERE username = 'user'
  AND NOT EXISTS (SELECT 1 FROM sys_registration);
