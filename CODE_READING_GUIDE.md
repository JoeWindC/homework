# 代码阅读指南

如果你想真正看懂这个项目，不要按“文件名”乱看，按“请求流”来读。

## 第一条线：先看登录和权限

1. `src/main/java/com/ouyeni/ylggxt/controller/AuthController.java`
   - 这里是登录、注册、退出的入口。
   - 重点看登录成功后 `loginUser` 是怎么放进 Session 的。

2. `src/main/java/com/ouyeni/ylggxt/entity/User.java`
   - 先看用户对象里有哪些字段。
   - 尤其看 `role` 和 `status`，它们决定权限和登录状态。

3. `src/main/java/com/ouyeni/ylggxt/service/impl/UserServiceImpl.java`
   - 看注册为什么默认写成 `user`。
   - 看登录为什么要检查账号状态。

4. `src/main/java/com/ouyeni/ylggxt/interceptor/LoginInterceptor.java`
   - 看“为什么没登录就进不去业务页”。
   - 这里只管是否登录，不管是不是管理员。

## 第二条线：再看管理员权限怎么落地

5. `src/main/java/com/ouyeni/ylggxt/controller/UserController.java`
   - 看管理员为什么能进用户管理面板。
   - 这里会判断 `role == 'admin'`，普通用户会被重定向回首页。

6. `src/main/java/com/ouyeni/ylggxt/controller/InfoController.java`
   - 看公告为什么所有人都能看，但只有管理员能发、能改、能删。

7. `src/main/java/com/ouyeni/ylggxt/controller/RegistrationController.java`
   - 看为什么同一个挂号页面，管理员和普通用户看到的不一样。
   - 这里通过 `adminView` 分流：管理员看全部，普通用户看自己的。

## 第三条线：最后看业务是怎么查数据库的

8. `src/main/java/com/ouyeni/ylggxt/service/impl/RegistrationServiceImpl.java`
   - 看预约为什么默认是“待处理”。
   - 看管理员为什么只能改成“已确认 / 已完成 / 已取消”。

9. `src/main/java/com/ouyeni/ylggxt/service/impl/InfoServiceImpl.java`
   - 看公告列表、搜索、发布、编辑、删除分别对应什么业务。

10. `src/main/resources/mapper/*.xml`
   - 最后去看 SQL。
   - 这里决定“到底查哪张表、更新哪一列”。

## 第四条线：再看页面为什么会变

11. `src/main/webapp/WEB-INF/jsp/common/header.jsp`
   - 看菜单为什么管理员和普通用户不一样。
   - 这里是页面层的角色分流。

12. `src/main/webapp/WEB-INF/jsp/registration/registrationList.jsp`
   - 看同一个挂号列表页为什么能切换“挂号管理”和“我的挂号”。

13. `src/main/webapp/WEB-INF/jsp/info/infoList.jsp`
   - 看公告列表页为什么普通用户看不到编辑删除按钮。

## 最后再看启动配置

14. `src/main/webapp/WEB-INF/web.xml`
15. `src/main/resources/spring/spring-mvc.xml`
16. `src/main/resources/spring/applicationContext-dao.xml`
17. `src/main/resources/spring/applicationContext-service.xml`
18. `src/main/resources/jdbc.properties`

这几份文件决定项目怎么启动、怎么连数据库、怎么扫到 Controller/Service/Mapper。

## 一句话理解权限

- 登录后把用户放进 `Session`。
- `LoginInterceptor` 只负责拦住没登录的人。
- `role == 'admin'` 决定是不是管理员。
- 页面只负责显示按钮，后端 Controller 还会再判断一次，避免越权。
