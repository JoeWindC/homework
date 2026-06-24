# 我的作业

## 医院挂号叫号系统

学生：RDB

学号：2406102315

## 技术栈

- JDK 21
- Tomcat 9
- Maven
- Spring 5.3.39
- SpringMVC
- MyBatis
- MySQL 8
- JSP + JSTL

## 数据库

数据库名：`db_2406102315_rdb`

数据库账号：`root`

数据库密码：`root`

初始化脚本：`sql/init.sql`

## 默认账号

管理员账号：`admin`

管理员密码：`123456`

普通用户账号：`user`

普通用户密码：`123456`

## 常用访问地址

实际访问前缀取决于 Tomcat 部署的 Application context。若 IDEA 默认部署为项目名，前缀通常是：

`http://localhost:8080/2406102315_RDB_YYGHJHXT_war_exploded`

常用页面：

- 登录页：`/login`
- 注册页：`/register`
- 首页：`/index`
- 公告列表：`/infos`
- 公告发布：`/infos/add`
- 用户管理：`/users`
- 退出登录：`/logout`

## 截图路线

1. IDEA 项目目录结构：展开 `src/main/java`、`src/main/resources`、`src/main/webapp`、`sql/init.sql`。
2. 注册页面：访问 `/register`，可先提交空账号或重复账号展示校验。
3. 登录页面：访问 `/login`，输入错误账号密码展示错误提示。
4. 管理员用户管理：使用 `admin / 123456` 登录后访问 `/users`。
5. 管理员公告发布/编辑：管理员访问 `/infos/add` 或 `/infos` 中点击编辑。
6. 普通用户公告浏览：使用 `user / 123456` 登录后访问 `/infos`，页面无编辑、删除按钮。
