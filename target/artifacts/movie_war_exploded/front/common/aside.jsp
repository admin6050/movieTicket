<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="aside">
	<div class="panel">
		<div class="panel-header">
			<span class="panel-title">
				<span class="textcolor_red">今日票房</span>
			</span>
		</div>
		<div class="panel-content">
			<ul class="ranking-wrapper ranking-box">
				<c:forEach items="${jrpf}" var="item">
					<li class="ranking-index-1">
						<a href="/front/detail.do?id=${item.id}" target="_blank">
							<div class="ranking-top-left">
								<i class="ranking-top-icon"></i>
								<img style="width: 80px;" class="ranking-img default-img" src="${item.imgpath}">
							</div>
							<div class="ranking-top-right">
								<div class="ranking-top-right-main">
									<span class="ranking-top-movie-name">
										${item.movieName}
									</span>
									<p class="ranking-top-wish">
										票房：${item.boxOffice}
									</p>
								</div>
							</div>
						</a>	
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<div class="panel-header">
			<span class="panel-title">
				<span class="textcolor_red">新闻公告</span>
			</span>
		</div>
		<div class="panel-content">
			<ul class="ranking-wrapper ranking-box">
				<c:forEach items="${newsList}" var="item">
					<li class="ranking-index-1">
						<a href="/front/detailNews.do?id=${item.id}" target="_blank">							
							<div class="ranking-top-right">
								<div class="ranking-top-right-main">
									<span class="ranking-top-movie-name">
										${item.title}
									</span>									
								</div>
							</div>
						</a>	
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<div class="panel-header">
			<span class="panel-title">
				<span class="textcolor_red">好评如潮</span>
			</span>
		</div>
		<div class="panel-content">
			<ul class="ranking-wrapper ranking-mostExpect">
				<c:forEach items="${hprc}" var="item">
					<li class="ranking-index-1">
						<a href="/front/detail.do?id=${item.id}" target="_blank">
							<div class="ranking-top-left">
								<i class="ranking-top-icon"></i>
								<img class="ranking-img default-img" src="${item.imgpath}">
							</div>
							<div class="ranking-top-right">
								<div class="ranking-top-right-main">
									<span class="ranking-top-movie-name">
										${item.movieName}
									</span>
									<p class="ranking-release-time">
										首映时间：${item.publishDate}
									</p>
									<p class="ranking-top-wish">
										票房：${item.boxOffice}
									</p>
								</div>
							</div>
						</a>	
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>








