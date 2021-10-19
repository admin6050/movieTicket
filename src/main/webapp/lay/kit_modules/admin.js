/** kitadmin-v2.1.0 MIT License By http://kit.zhengjinfan.cn Author Van Zheng */
;
"use strict";
var mods = ["element", "sidebar", "mockjs", "select", "tabs", "menu", "route", "utils", "component", "kit"];
layui.define(mods,
function(e) {
    layui.element;
    var t = layui.utils,
    a = layui.jquery,
    n = (layui.lodash, layui.route),
    i = layui.tabs,
    l = layui.layer,
    o = layui.menu,
    m = layui.component,
    s = layui.kit,
    p = function() {
        this.config = {
            elem: "#app",
            loadType: "SPA"
        },
        this.version = "1.0.0"
    };
    p.prototype.ready = function(e) {
        var i = this.config,
        o = (0, t.localStorage.getItem)("KITADMIN_SETTING_LOADTYPE");
        null !== o && void 0 !== o.loadType && (i.loadType = o.loadType),
        s.set({
            type: i.loadType
        }).init(),
        u.routeInit(i),
        u.menuInit(i),
        "TABS" === i.loadType && u.tabsInit(),
        "" === location.hash && t.setUrlState("主页", "#/"),
        
        a("#cc").on("click",
        function() {
            layui.sidebar.render({
                elem: this,
                title: "这是表单盒子",
                shade: !0,
                dynamicRender: !0,
                url: "views/form/index.html",
                width: "50%"
            })
        }),
        m.on("nav(header_right)",
        function(e) {
            var t = e.elem.attr("kit-target");
            "setting" === t && layui.sidebar.render({
                elem: e.elem,
                title: "设置",
                shade: !0,
                dynamicRender: !0,
                url: "views/setting.html"
            }),
            "help" === t && l.alert("")
        }),
        layui.mockjs.inject(APIs),
        "SPA" === i.loadType && n.render(),
        "function" == typeof e && e()
    };
    var u = {
        routeInit: function(e) {
            var t = this,
            a = {                
                //路由地址
                routes: [				
                	{
	                	path: "/",
	                	component: "views/app.html",
	                	name: "主页"
	                },
                    {
                        path: "/users/query",
                        component: "views/users/query.jsp",
                        name: "用户管理"
                    },
                    {
                        path: "/movies/add",
                        component: "views/movies/add.jsp",
                        name: "新增电影信息"
                    },
                    {
                        path: "/movies/query",
                        component: "views/movies/query.jsp",
                        name: "电影信息查询"
                    },
                    {
                        path: "/movies/ticket",
                        component: "views/movies/ticket.jsp",
                        name: "电影票管理"
                    },
                    {
                        path: "/news/add",
                        component: "views/news/add.jsp",
                        name: "新增站内新闻"
                    },
                    {
                        path: "/news/query",
                        component: "views/news/query.jsp",
                        name: "站内新闻查询"
                    },
                    {
                        path: "/movies/orders",
                        component: "views/movies/orders.html",
                        name: "订单管理"
                    }
                ]
            };
            return "TABS" === e.loadType && (a.onChanged = function() {
                i.existsByPath(location.hash) ? i.switchByPath(location.hash) : t.addTab(location.hash, (new Date).getTime())
            }),
            n.setRoutes(a),
            this
        },
        addTab: function(e, t) {
            var a = n.getRoute(e);
            a && i.add({
                id: t,
                title: a.name,
                path: e,
                component: a.component,
                rendered: !1,
                icon: "&#xe62e;"
            })
        },
        menuInit: function(e) {
            var t = this;
            return o.set({
                dynamicRender: !1,
                isJump: "SPA" === e.loadType,
                onClicked: function(a) {
                    if ("TABS" === e.loadType && !a.hasChild) {
                        var n = a.data,
                        i = n.href,
                        l = n.layid;
                        t.addTab(i, l)
                    }
                },
                elem: "#menu-box",
                remote: {
                    url: "/api/getmenus",
                    method: "post"
                },
                cached: !1
            }).render(),
            t
        },
        tabsInit: function() {
            i.set({
                onChanged: function(e) {}
            }).render(function(e) {
                e.isIndex && n.render("#/")
            })
        }
    }; (new p).ready(function() {
        console.log("Init successed.")
    }),
    e("admin", {})
});
