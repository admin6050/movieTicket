<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>登录</title>

  <script type="text/javascript" src="../vue.js"></script>
  <script type="text/javascript" src="../vue-resource.js"></script>
  <script src="../layui.js"></script>
  <link rel="stylesheet" href="../css/layui.css" id="layui">
  <style type="text/css">
    .title{
      text-align: center;
      font-size: 20px;
      padding-top: 30px;
    }
    .window{
      width: 400px;
      position: absolute;
      margin-left: -200px;
      margin-top: -80px;
      top:30%;
      left: 50%;
      display: block;
      z-index: 100;
      background: #fff;
      padding: 20px;
    }
  </style>
</head>

<body style="background:#f1f1f1;">
<div class="window">
  <form class="layui-form" method="post">
    <div class="title">
      登陆界面
    </div>
    <div class="layui-form-item" style="margin-top: 20px;margin-right: 100px;">
      <label class="layui-form-label">用户名:</label>
      <div class="layui-input-block">
        <input class="layui-input" type="text" id="name" name="name" required lay-verify="required" placeholder="请输入用户名">
      </div>
    </div>
    <div class="layui-form-item" style="margin-right: 100px;">
      <label class="layui-form-label">密码:</label>
      <div class="layui-input-block">
        <input class="layui-input" type="password" id="password" name="password" required lay-verify="required" placeholder="请输入密码">
      </div>
    </div>

    <div id="authBox" class="layui-form-item" style="margin-right: 100px;">
      <label class="layui-form-label">权限:</label>
      <div class="layui-input-block" style="width: 190px;">
        <select name="auth" id="auth" lay-verify="required">
          <option value="注册用户">注册用户</option>
          <option value="管理员">管理员</option>
        </select>
      </div>
    </div>

    <div id="regBox" class="layui-form-item">
      <div  style="text-align: right;margin-right: 100px;">
        我要<a href="javascript:reg();">注册</a>
      </div>
    </div>

    <div class="layui-form-item">
      <div style="text-align: center;">
        <input class="layui-btn" value="&nbsp;&nbsp;&nbsp;登录&nbsp;&nbsp;" type="button" id="loginBtn" onclick="login11()">
        <%--默认隐藏--%>
        <input style="display: none;" class="layui-btn" value="&nbsp;&nbsp;&nbsp;注册&nbsp;&nbsp;" type="button" id="regBtn" onclick="handleReg()">
      </div>
    </div>
  </form>
</div>
<script type="text/javascript">
  layui.use(["form",'jquery'],function(){
    window.$ = layui.$;
    layer=layer;
  });
  /*登录*/
  function login11() {
    var name = $("#name").val();
    var password = $("#password").val();
    var auth = $("#auth").val();
    if (!name){
      alert("用户名不能为空");
      return;
    }
    if (!password){
      alert("密码不能为空");
      return;
    }
    /*jquery*/
    $.post('/users/login.do',{
      name: name,
      password: password,
      auth: auth
    },function(data){
      if(data.code<0){
        alert(data.errMsg);
      }else if(data.code==1){//注册用户
        location.href = "/front/index.do";
      }else{/*管理员*/
        location.href = "/#/";
      }
    },'json');
  }

  /*点击'我要注册'有些显示隐藏，和显示*/
  function reg() {
    $(".title").html("注册界面");
    $("#authBox").hide();
    $("#regBox").hide();
    $("#loginBtn").hide();
    $("#regBtn").show();

  }
  /*点击  ‘注册’按钮,管理员不允许注册*/
  function handleReg() {
    var name = $("#name").val();
    var password = $("#password").val();
    $.post("/users/reg.do",{
      name: name,
      password: password
    },function (data) {
      if(data.code<0){/*用户名存在*/
        alert(data.errMsg);
      }else{/*注册成功,跳转到登录页面*/
        alert("注册成功");
        location.href="/front/login.jsp";
      }
    })

  }
</script>
</body>
</html>