<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/layui.css" id="layui">
</head>
<script type="text/javascript" src="">

</script>
<body>
<div class="header">
    <div class="header-inner">
        <a href="/front/index.do" class="logo">电影订票网站</a>
        <div style="float:right;width:250px;margin-top:20px;margin-left:150px;">
            <c:choose>
                <c:when test="${sessionScope.currentUser==null}">
                    <a href="/front/login.jsp">
                        <button class="layui-btn layui-btn-normal">用户登录</button>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="/front/userLogout.do">
                        <button class="layui-btn layui-btn-normal">欢迎您，${sessionScope.currentUser.name}</button>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
        <form action="/front/result.do" style="float:right;" target="_blank" class="search-form">
            <input name=moviename class="search" type="search" maxlength="30" placeholder="找电影">
            <input class="submit" type="submit" value="">
        </form>
    </div>
</div>
</body>
</html>
