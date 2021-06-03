<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("AdministratorName")==null)
    response.sendError(403, "No Admin Login");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'UpdatePassword.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- link rel="stylesheet" type="text/css" href="styles.css" -->

  </head>
  
  <body>
<%@ include file="db.jsp"%><%
      String username=request.getParameter("Username"); 
	  String password=request.getParameter("Password"); 
      Statement sts=conn.createStatement();
      String sql="update user set u_passwd='"+password+"' where u_name='"+username+"'";
      sts.executeUpdate(sql);
      if (sts.getUpdateCount() == 1)
	    out.print("修改信息成功!" + username);
      else
	    out.print("修改信息失败!" + username);
    %>
  </body>
</html>
