<%@ page language="java" import="java.util.*, java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String name=request.getParameter("AdministratorName");
String password=request.getParameter("AdministratorPassword");

int count=0;
String s="select * from Administrator where name='"+name+"' and password='"+password+"'";

%><%@ include file="db.jsp"%><%

	ResultSet rs = conn.prepareStatement(s).executeQuery();
	while(rs.next()) count++; 
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录<%=count==1?"成功":"失败"%></title>
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
  <%if(count==1){
       session.setAttribute("AdministratorName",name);
	   response.sendRedirect("AdminMain.html");} 
	else{%>
           很遗憾，登录失败,<%=name%><br/>
  <%}%>
  </body>
  </html>
