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
  	.ranking-item .panel {width: 500px;float:left; padding:10px;}
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
								<span class="textcolor_red">搜索结果</span>
							</span>
						</div>
						<div class="panel-content">
							<ul>
								<c:forEach items="${moviesList}" var="item">
									<li class="ranking-item ranking-top ranking-index-1">
										<a href="/front/detail.do?id=${item.id}" target="_blank">
											<div class="ranking-top-left">
												<img style="width:188px;float:left;" class="ranking-img default-img" src="${item.imgpath}">
												<div class="panel">
													${item.description }
												</div>
												<div style="clear:both;"></div>
											</div>
											<div class="ranking-top-right">
												<div class="ranking-top-right-main">
													<span class="ranking-top-movie-name">${item.movieName}</span>
													<p class="ranking-top-wish">票房：${item.boxOffice}万</p>
												</div>
											</div>
											
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					
				</div>
			</div>
		</div>	
	</div>
	<%@include file="./common/footer.jsp" %>
</body>
</html>










