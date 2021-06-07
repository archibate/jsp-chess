<%@ page language="java" import="java.util.*,java.sql.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%//接收管理员端提交的数据
 String username=request.getParameter("Username");
 String password=request.getParameter("Password");
 String sex=request.getParameter("Sex");
%>
<%//构造追加记录SQL语句
 String sqlString=null;//SQL语句
 java.util.Date date=new java.util.Date();
 SimpleDateFormat ft=new SimpleDateFormat("yyyy-MM-dd");
 String registertime=ft.format(date);
 sqlString="insert into UserTable values('"+username+"','"+password+"','"+sex+"','"+registertime+"','"+point+"','"+round+"')";
%>
<%//执行SQL语句
	Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433; DatabaseName=Chess","sa","123456");
    Statement sts=conn.createStatement();
    sts.executeUpdate(sqlString);  
%>
<head>
<title>用户信息增加程序</title>
</head>
<body>
<%out.print("信息增加成功！");%>
</body>
</html>
