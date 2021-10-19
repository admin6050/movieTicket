<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>电影购票系统</title>
    <link rel="stylesheet" href="./css/main.css">
    <style type="text/css">
        .item {color:#666;margin:10px;}
        .btn.buy {
            margin-top:50px;
            width:250px;
            height:40px;
            font-size:16px;
            line-height:40px;
            text-align:center;
            border-radius: 15px;
            float: right;
        }
        .seat {text-align:center;cursor:pointer;margin:15px;width:40px;padding:10px 20px;background:#eaeaea;border:1px solid #666;float:left;border-radius:20px;}
        .seat2 {background:red !important;color:#fff;text-align:center;cursor:pointer;margin:15px;width:40px;padding:10px 20px;background:#eaeaea;border:1px solid #666;float:left;border-radius:20px;}
    </style>
</head>

<body>
<%@include file="./common/header.jsp" %>
<div class="header-placeholder"></div>
<div id="app" class="container">
    <div class="content">
        <%@include file="./common/aside.jsp" %>
        <div class="main">
            <div class="movie-grid">
                <div class="panel">
                    <div class="panel-header">
							<span class="panel-title">
								<span class="textcolor_red">电影票在线订购</span>
							</span>
                    </div>
                    <div class="panel-content">
                        <div style="height:380px;">
                            <div style="float:left;">
                                <img style="width:280px;" src="${movies.imgpath}">
                            </div>
                            <div style="float:left;padding-left:20px;width:420px;height:100%;">
                                <h2>${movies.movieName}</h2>
                                <div class="item">导演：${movies.director}</div>
                                <div class="item">时长：${movies.time}</div>
                                <div class="item">首映日期：${movies.publishDate}</div>
                                <div class="item">票房：${movies.boxOffice}</div>
                                <div class="item">电影简介：${movies.description}</div>
                                <div class="item">票价：<span style="color:red;font-size:30px;">￥${movies.ticketPrice}</span></div>
                            </div>
                        </div>
                        <div>
                            <a class="btn buy">特惠购票（点击座位购票）</a>
                            <div style="clear:both;height:80px;"></div>
                        </div>
                        <div>
                            <c:forEach items="${tickets}" var="item">
                                <c:choose>
                                    <c:when test="${item.occupy == '空余座位' }">
                                        <div onclick='buyTicket("${item.id}")' class="seat">${item.seat}</div>
                                    </c:when>
                                    <c:when test="${item.occupy == '售出座位' }">
                                        <div class="seat2">${item.seat}</div>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="jquery.js"></script>
<script type="text/javascript">
    //买票
    function buyTicket(id){
        if(!"${sessionScope.currentUser}"){
            alert("请先登录！");
            return;
        }
        if(!confirm('您确定要订票吗？')){
            return;
        }
        $.post("/movies/addOrder.do",{id:id},function(data){
            if(data.code<0){
                alert("系统出错了！");
                return;
            }
            alert("订票成功！");
            window.location.reload();
        },'json');
    }
</script>
<%@include file="./common/footer.jsp" %>
</body>
</html>
