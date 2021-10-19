<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台管理</title>

    <script type="text/javascript" src="vue.js"></script>
    <script type="text/javascript" src="vue-resource.js"></script>
    <link rel="stylesheet" href="css/layui.css" id="layui">
    <link rel="stylesheet" href="css/theme/default.css" id="theme">
    <link rel="stylesheet" href="css/kitadmin.css" id="kitadmin">
    <script src="lay/modules/laydate.js"></script>
    <script type="text/javascript">
        /*防止用户点击退出之后，刷新又返回后台页面*/
        if (!"${sessionScope.adminUser}") {/*查看session信息是否还存在*/
            location.href = "front/login.jsp";//不存在跳转到登录界面
        }
    </script>
</head>

<body class="layui-layout-body kit-theme-default">
<div class="layui-layout layui-layout-admin">
    <!-- header -->
    <div class="layui-header">
        <div class="layui-logo">
            <div class="layui-logo-toggle" kit-toggle="side" data-toggle="on">
                <i class="layui-icon">&#xe65a;</i>
            </div>
            <div class="layui-logo-brand">
                <a href="#/">后台系统</a>
            </div>
        </div>
        <div class="layui-layout-right">
            <ul class="kit-nav" lay-filter="header_rigtht">
                <li class="kit-item">
                    <a href="users/logout.do">注销</a>
                </li>
            </ul>
        </div>
    </div>
    <%--左侧菜单部分--%>
    <div class="layui-side" kit-side="true">
        <div class="layui-side-scroll">
            <div id="menu-box">
                <ul class="kit-menu">
                    <li class="kit-menu-item">
                        <a href="#/">
                            <i class="layui-icon">&#xe631;</i>首页
                        </a>
                    </li>
                    <li class="kit-menu-item">
                        <a href="#/users/query">
                            <i class="layui-icon">&#xe631;</i>用户管理
                        </a>
                    </li>
                    <li class="kit-menu-item">
                        <a href="javascript:;">
                            <i class="layui-icon">&#xe631;</i>影片管理
                        </a>
                        <ul class="kit-menu-child layui-anim layui-anim-upbit">
                            <li class="kit-menu-item">
                                <a href="#/movies/add">
                                    <i class="layui-icon">&#xe60a;</i>新增电影信息
                                </a>
                            </li>
                            <li class="kit-menu-item">
                                <a href="#/movies/query">
                                    <i class="layui-icon">&#xe60a;</i>电影信息列表
                                </a>
                            </li>
                            <li class="kit-menu-item">
                                <a href="#/movies/ticket">
                                    <i class="layui-icon">&#xe60a;</i>电影票管理
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="kit-menu-item">
                        <a href="javascript:;">
                            <i class="layui-icon">&#xe631;</i>新闻管理
                        </a>
                        <ul class="kit-menu-child layui-anim layui-anim-upbit">
                            <li class="kit-menu-item">
                                <a href="#/news/add">
                                    <i class="layui-icon">&#xe60a;</i>新增站内新闻
                                </a>
                            </li>
                            <li class="kit-menu-item">
                                <a href="#/news/query">
                                    <i class="layui-icon">&#xe60a;</i>站内新闻管理
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="kit-menu-item">
                        <a href="#/movies/orders">
                            <i class="layui-icon">&#xe60a;</i>订单管理
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- main -->
    <div class="layui-body" kit-body="true">
        <router-view></router-view>
        <%--lay/kit_modules/admin.js路由转向功能，#/--%>
    </div>
</div>
<script src="polyfill.min.js"></script>
<script src="layui.js"></script>
<script src="kitadmin.js"></script>
<script src="mockjs-config.js"></script>
<script>layui.use("admin");</script>

</body>


</html>