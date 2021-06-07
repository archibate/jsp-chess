<%@ page language="java" import="java.util.*, java.sql.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username=request.getParameter("Username");
String password=request.getParameter("Password");
String sex=request.getParameter("Sex");
String point="0";
String round="0";

java.util.Date date=new java.util.Date();
SimpleDateFormat ft=new SimpleDateFormat("yyyy-MM-dd");
String registertime=ft.format(date);

Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433; DatabaseName=Chess","sa","123456");

String sqlString="insert into UserTable values('"+username+"','"+password+"','"+sex+"','"+registertime+"','"+point+"','"+round+"')";
conn.prepareStatement(sqlString).executeUpdate();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册成功</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  恭喜您，注册成功, <%=username%><br/>
  </body>
</html>
