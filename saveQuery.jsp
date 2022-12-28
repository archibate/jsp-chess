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
<title>历史存档页面</title>
<meta name="description" content="Custom Login Form Styling with CSS3" />
<meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico"> 
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="table.css" />
<script src="js/modernizr.custom.63321.js"></script>
<!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
</head>
  <body>
    <div id="Layer" style="position:absolute; left:0px; top:0px; width:100%; height:100%">
     <img src="MetalChess.jpg" width="100%" height="100%"/>
    </div>
  <center>
<form class="form-4" style="width: 500px">
  <tr>
    <h1><td width="100%" colspan="2" align="center"><font color=white style="font-size: 40px">历 史 残 局 存 档</font></td></h1>
  </tr>
  <br/>
  <br/>
  <br/>
<%@ include file="db.jsp"%><%//执行SQL语句
  Statement sts=conn.createStatement();
  String sql="select * from save order by s_ctime DESC";
  ResultSet rs=sts.executeQuery(sql);
  int i=1;%>
<table class="imagetable"><tr><th>序号</th><th>保存时间</th><th>标题</th><th>我方颜色</th><th>已走步数</th><th>剩余棋子数</th><th>操作</th></tr>
<%while(rs.next()){
String state = rs.getString("s_state");
int leftchesses = 0;
for (int t = 0; t < 32; t++) {
    if (state.charAt(t * 2) != '-') leftchesses += 1;
}
int sno = rs.getInt("s_no");
out.print("<tr><td>"+i+"</td><td>"+rs.getString("s_ctime")+"</td><td>"+rs.getString("s_title")+"</td><td>"+(rs.getString("s_ownerColor").equals("red")?"红":"黑")+"</td><td>"+rs.getString("s_steps")+"</td><td>"+Integer.toString(leftchesses)+"</td><td><a href=\"saveLoad.jsp?sno="+Integer.toString(sno)+"\">加载</a> | <a href=\"saveDelete.jsp?sno="+Integer.toString(sno)+"\">删除</a></td></tr>");
        i++;}
  rs.close();%>
</form>
  </body>
</html>
