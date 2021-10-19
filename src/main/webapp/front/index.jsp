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
								<span class="textcolor_red">正在热映</span>
							</span>
                        </div>
                        <div class="panel-content">
                            <dl class="movie-list">
                                <c:forEach items="${moviesList}" var="item">
                                    <dd>
                                        <div class="movie-item">
                                            <a href="/front/detail.do?id=${item.id}" target="_blank">
                                                <div class="movie-poster">
                                                    <img src="${item.imgpath}">
                                                    <div class="movie-overlay movie-overlay-bg">
                                                        <div class="movie-info">
                                                            <div class="movie-title movie-title-padding">${item.movieName }</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </a>
                                            <div class="movie-detail movie-detail-strong movie-sale">
                                                <a href="/front/detail.do?id=${item.id}" target="_blank" class="active">
                                                    购票
                                                </a>
                                            </div>

                                        </div>
                                    </dd>
                                </c:forEach>
                            </dl>
                        </div>
                    </div>

                    <div class="panel">
                        <div class="panel-header">
							<span class="panel-title">
								<span class="textcolor_red">最受期待</span>
							</span>
                        </div>
                        <div class="panel-content">
                            <dl class="movie-list">
                                <c:forEach items="${zsqd}" var="item">
                                    <dd>
                                        <div class="movie-item">
                                            <a href="/front/detail.do?id=${item.id}" target="_blank">
                                                <div class="movie-poster">
                                                    <img src="${item.imgpath}">
                                                    <div class="movie-overlay movie-overlay-bg">
                                                        <div class="movie-info">
                                                            <div class="movie-title movie-title-padding">${item.movieName }</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </a>
                                            <div class="movie-detail movie-rt">
                                                <a href="/front/detail.do?id=${item.id}" target="_blank">
                                                        ${item.publishDate}
                                                </a>
                                            </div>

                                        </div>
                                    </dd>
                                </c:forEach>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="./common/footer.jsp" %>
</body>
</html>