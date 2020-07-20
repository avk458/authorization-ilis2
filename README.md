# ilis2 授权管理中心开发文档

## 前言

​	`ilis2`作为一个`SaaS`平台，在平台生命周期中客户数量会随着市场的开拓随之增长，为了规范和加强对客户、以及程序自身的管理，设计开发了此授权管理系统。本系统将部署两套，一套位于内网开发、测试环境，另一台位于线上环境。

​	本手册适用于开发、运维以及测试人员。在本手册中，

* 👨🏻‍💻代表针对开发人员
* 🧑🏻‍🔧代表针对运维人员
* 🧑🏻‍🔬代表针对测试人员

## 设计目的

* 管理ilis2租户的授权管理
* 管理ilis2租户数据库初始化、更新数据版本
* 管理ilis2租户的客户登录鉴权
* 管理ilis2租户客户相关统计

## 模块介绍

### 仪表盘

该页面位于系统首页，系用户首次进入系统后查看到的各项指标值的统计信息汇总

![dashboard](https://i.loli.net/2020/07/12/xi8fnEwQk5I3lta.png)

1. 系统路由，根据用户成功登录后返回的用户角色进行条件渲染

 	2. 路由面包屑
      	1. 面包屑用于存储用户进入过的页面，通过面包屑中的`tag`可以快速重新进入
      	   2. 👨🏻‍💻前端可以根据实际情况进行配置，选择面包屑中展示（如：`sideBar`中的父级路由）
      	   3. 前端会将用户的使用情况存入`cookie`中
 	3. 用户相关
      	1. 消息（暂未开发）
      	   2. 修改密码
      	   3. 退出系统
 	4. 系统数据展示卡片
      	1. 当前数据库脚本的版本
      	   2. 使用`ilis2`的所有租户单位的客户数量
      	   3. 当前所有租户单位的在线客户数量
 	5. 单位用户占比，展示了所有租户的客户使用占比
 	6. 周活跃用户，展示了所有租户每周的活跃用户
 	7. 当日各租户单位的每小时活跃用户

### 用户单位模块

#### 用户管理

1. 各个租户的用户使用量
2. 各个租户的用户登录日志

#### 单位信息管理

![截屏2020-07-12 下午3.17.31](https://i.loli.net/2020/07/12/aq5LZIjFkYNge6p.png)

##### 新增单位

<img src="https://i.loli.net/2020/07/12/t12vA9U6PBZldJ7.png" alt="addUnitInfo" style="zoom:50%;" />

1. 系统会自动根据单位的简称，汉字取拼音首字母或阿拉伯数字或英文字母作为唯一标识符
2. 🧑🏻‍🔧亦可修改自定义的、不可与现有的唯一标识符相同的唯一标识符
3. 最大在线用户数不能超过最大用户数
4. 单点登录控制`ilis2`客户端是否允许重复登录
5. 过期时间默认当前时间的一个月后
6. 目标数据源
7. 当提交校验通过后的新增单位信息，系统会根据启用的[主数据源](#####主数据源)自动创建以及初始化该单位所使用的数据库，数据库初始用户名和密码由`ilis_`加单位唯一标识符构成（如：`ilis_hitek`），🧑🏻‍🔧运维人员可以在初始化完成后进行修改

##### 单位信息列表

![unitInfo](https://i.loli.net/2020/07/12/aq5LZIjFkYNge6p.png)

1. 申请授权（暂未开发）
2. 编辑/删除的权限控制详见菜单权限，当单位信息有正在已被初始化的单位数据库信息时无法直接删除

### 数据库

#### 单位数据库信息

![databaseList](https://i.loli.net/2020/07/12/KZ1CvBwuPkFUlL6.png)

在创建单位信息的时会自动创建单位所使用的数据库，故禁用了新增单位数据库

##### 数据库升级

在开发过程中，因需求会不断的更新数据库的数据结构。因此需要管理不同版本主程序数据库数据升级。数据库升级分为：

1. 单个数据库升级：

   1. `ilis2`的有两种不同类型的租户，一种是直接使用`ilis2`服务的租户，这种租户可以由授权中心直接管理
   2. 另一种为单独部署的租户，这种租户不能直接管控单独部署的数据库
   3. 若数据库无法直接管控，则升级功能不可用。需进入主程序中的海特后台管理菜单中的数据库升级中进行升级

2. 数据库批量升级

   该功能会将所有能管控的数据库一起升级

3. 所有升级都会升级到最新的数据版本

4. 升级完成后的提示

   1. 

   ![databaseUpdateLog](https://i.loli.net/2020/07/12/apQM4LHjKyniDU8.png)

   2. 如过程遇到错误，可以查看错误日志并导出

#### 单位数据管理

![databaseManage](https://i.loli.net/2020/07/12/yO5K4fsDrcnRLIq.png)

可以查看各个数据库信息

##### 数据库字段同步

![synchronizer](https://i.loli.net/2020/07/12/F6DzPqaSUBtJpMT.png)

👨🏻‍💻可以在内网开发环境中选择使用，该功能会根据所选主库的所有改动同步至所选目标库，因其他原因该功能暂未启用备份回滚功能，故尽量选用数据库信息中的批量升级功能。

##### 导出数据库脚本

👨🏻‍💻适用于内网环境，将数据库脚本中的数据导出

##### 导入数据库脚本

👨🏻‍💻适用于外网环境，将内网导出的数据脚本导入到外网授权中心

#### 👨🏻‍💻数据脚本管理

###### 提交脚本

![addScript](https://i.loli.net/2020/07/12/YPFWGI6BfruU9ye.png)

##### 脚本管理

![scriptList](https://i.loli.net/2020/07/12/V85HLziq2SXfKBA.png)

1. 👨🏻‍💻可以根据开发中的实际情况拖动改变脚本的执行顺序
2. 系统会校验并识别所提供脚本，在执行脚本时，`DML`类型的脚本会开启数据库事务

### 系统设置

#### 数据源配置管理

![profileManage](https://i.loli.net/2020/07/12/NdOLp6uTlwiXYSC.png)

##### 主数据源

1. 👨🏻‍💻由开发人员制作标准库，标准库为`ilis2`主程序所使用的初始化状态数据库
2. 👨🏻‍💻根据实际情况可配置多种类型的主数据源
3. 🧑🏻‍🔧根据租户的单位类型选择启用主数据源

##### 目标数据源

1. 🧑🏻‍🔧根据租户指定
2. 在新增目标数据源时，会根据提供的数据源信息检测，检测结果代表租户数据库可否直接管控

所有数据源的密码均均存储为加密字符串，在修改配置数据源密码时，留空则不修改

#### 初始化文件管理

![initFile](https://i.loli.net/2020/07/12/le28oCau4tQyimW.png)

作为初始化租户数据库的文件留存记录

#### 系统用户

![sysUsers](/Users/kano/Desktop/sysUsers.png)

授权中心系统用户管理，授权中心不开放注册，均有管理员配置用户

#### 角色管理

![sysRoles](/Users/kano/Desktop/sysRoles.png)

#### 菜单管理

![sysMenus](https://i.loli.net/2020/07/12/zUNBA9gE3kHC1uI.png)

## 其他

### 网络安全

1. 授权中心后端使用`Spring Security`默认开启`CSRP XST HTTPFirewall Protection`
2. 授权中心提供的租户登录校验API以RSA加密数据传输，加解密均由程序后端完成

### API

1. 授权管理中心以RPC的方式封装API
2. 🧑🏻‍🔬非内网环境下，开启了基于滑动窗口算法的API接口限流
