<%--
  Created by IntelliJ IDEA.
  User: WLQ
  Date: 2021/10/13
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件上传</title>
</head>
<body>
    <form method="post" action="/imageUpload" enctype="multipart/form-data">
        上传文件:<input type="file" name="file1"><br/>
        <input type="submit" value="提交">
    </form>
</body>
</html>
