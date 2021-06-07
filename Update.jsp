<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-cn">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>更新用户页面</title>
<meta name="description" content="Custom Login Form Styling with CSS3" />
<meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico"> 
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/modernizr.custom.63321.js"></script>
<!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
</head>
  <body>
    <div id="Layer" style="position:absolute; left:0px; top:0px; width:100%; height:100%">
     <img src="BambooPlus.jpg" width="100%" height="100%"/>
    </div>
  <center>
<form class="form-4" action="UpdatePassword.jsp" method="get">
  <tr>
    <h1><td width="100%" colspan="2" align="center"><font color=white>象棋用户信息更新平台</font></td></h1>
  </tr>
  <br/>
  <br/>
  <br/>
  <tr>
    <td width="35%">请输入需要修改的用户名:</td>
    <td width="65%"><input type="text" name="Username"></td>
  </tr>
  <tr>
    <td width="35%">请输入其新的密码:</td>
    <td width="65%"><input type="text" name="Password"></td>
  </tr>
    <tr>
    <td colspan="2" align="center">　<input type="submit" value="提交"></td>
    </tr>
  </form>
</center>
</body>
</html>
