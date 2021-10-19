<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>电影购票系统</title>
  <link rel="stylesheet" href="./css/main.css">
  <style type="text/css">
  	.box1 {}
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
								<span class="textcolor_red">新闻公告</span>
							</span>
						</div>
						<div class="panel-content">
							<div class="box1">
								<h1 style='text-align:center;'>${news.title}</h1>
								<br>
								<div>
								${news.content}
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>	
	</div>
	<%@include file="./common/footer.jsp" %>
</body>
</html>










