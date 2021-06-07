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
<title>积分排行榜页面</title>
<meta name="description" content="Custom Login Form Styling with CSS3" />
<meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico"> 
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/modernizr.custom.63321.js"></script>
    <style type="text/css">
    table.imagetable {
        font-family: verdana,arial,sans-serif;
        font-size:11px;
        color:#333333;
        border-width: 1px;
        border-color: #999999;
        border-collapse: collapse;
    }
    table.imagetable th {
        background:#b5cfd2 url('cell-blue.jpg');
        border-width: 1px;
        padding: 8px;
        border-style: solid;
        border-color: #999999;
    }
    table.imagetable td {
        background:#dcddc0 url('cell-grey.jpg');
        border-width: 1px;
        padding: 8px;
        border-style: solid;
        border-color: #999999;
    }
    </style>
<!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
</head>
  <body>
    <div id="Layer" style="position:absolute; left:0px; top:0px; width:100%; height:100%">
     <img src="BambooPlus.jpg" width="100%" height="100%"/>
    </div>
  <center>
<form class="form-4">
  <tr>
    <h1><td width="100%" colspan="2" align="center"><font color=white>用 户 积 分 排 行 榜</font></td></h1>
  </tr>
  <br/>
  <br/>
  <br/>
<%@ include file="db.jsp"%><%//执行SQL语句
  Statement sts=conn.createStatement();
  String sql="select * from user order by u_point DESC";
  ResultSet rs=sts.executeQuery(sql);
  int i=1;%>
<table class="imagetable"><tr><th>名次</th><th>用户名</th><th>积分</th><th>总局数</th><th>胜率</th></tr>
<%while(rs.next()){
  int pointint=Integer.parseInt(rs.getString("u_point"));
  int roundint=Integer.parseInt(rs.getString("u_round"));
  int rate=pointint*100/Math.max(roundint,1);
        out.print("<tr><td>"+i+"</td><td>"+rs.getString("u_name")+"</td><td>"+rs.getString("u_point")+"</td><td>"+rs.getString("u_round")+"</td><td>"+rate+"%</td></tr>");
        i++;}
  rs.close();%>
</form>
  </body>
</html>
