# 实验报告图稿

下面两张图对应报告第 2 章里的要求，直接复制到支持 Mermaid 的编辑器里即可渲染。

## 图 1 系统 MVC/SSM 分层架构图

```mermaid
flowchart LR
    Browser[浏览器 / JSP 页面] -->|HTTP 请求| Controller[SpringMVC Controller]
    Controller -->|调用业务| Service[Spring Service]
    Service -->|调用数据访问| Mapper[MyBatis Mapper]
    Mapper -->|执行 SQL| DB[(MySQL 数据库)]
    DB -->|返回数据| Mapper
    Mapper -->|返回实体对象| Service
    Service -->|组装模型数据| Controller
    Controller -->|JSP 渲染| Browser

    subgraph Presentation[表现层]
        Browser
    end

    subgraph MVC[MVC 控制层]
        Controller
    end

    subgraph Business[业务层]
        Service
    end

    subgraph DataAccess[数据访问层]
        Mapper
    end

    subgraph Database[数据库层]
        DB
    end
```

## 图 2 系统功能模块结构图

```mermaid
flowchart TB
    A[医院挂号叫号系统] --> B[认证管理]
    A --> C[用户管理]
    A --> D[医疗公告管理]
    A --> E[预约挂号管理]
    A --> F[候诊叫号显示]
    A --> G[首页统计与个人中心]
    A --> H[身份核验与权限控制]

    B --> B1[登录]
    B --> B2[注册]
    B --> B3[退出]

    C --> C1[用户列表]
    C --> C2[启用/禁用]
    C --> C3[删除用户]

    D --> D1[公告列表]
    D --> D2[公告详情]
    D --> D3[发布/编辑/删除]

    E --> E1[挂号预约]
    E --> E2[我的预约]
    E --> E3[管理员确认/完成/取消]

    F --> F1[待叫号列表]
    F --> F2[叫号状态展示]

    G --> G1[首页统计]
    G --> G2[个人中心]

    H --> H1[登录拦截]
    H --> H2[角色判断]
```

## 使用建议

- 如果只放一张图，优先放“图 1 系统 MVC/SSM 分层架构图”。
- 如果老师要求“系统功能模块图”，就把“图 2”也放进报告。
- 这两张图和你当前代码结构是对得上的。

