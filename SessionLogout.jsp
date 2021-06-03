<%@ page language="java" import="java.util.*,java.sql.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
session.invalidate();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<title>中国象棋 | 用户登出</title>
</head>
<body>
恭喜您，成功登出！
</body>
</html>
<%
response.sendRedirect("login.html");
%>
