<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>查询用户页面</title>
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
<form class="form-4">
  <tr>
    <h1><td width="100%" colspan="2" align="center"><font color=white>象棋用户信息查询平台</font></td></h1>
  </tr>
  <br/>
  <br/>
  <br/>
<%@ include file="db.jsp"%><%
   Statement sts=conn.createStatement();
   String sql="select * from UserTable";
   ResultSet rs=sts.executeQuery(sql);%>
   <table border=1><tr><td>用户名</td><td>密码</td><td>性别</td><td>注册时间</td></tr>
   <% 
   while(rs.next())
   out.print("<tr><td>"+rs.getString("username")+"</td><td>"+rs.getString("password")+"</td><td>"+rs.getString("sex")+"</td><td>"+rs.getString("registertime")+"</td></tr>");
   rs.close();
   %>
   </form>
  </body>
</html>
