<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<%@ include file="db.jsp"%><%
Statement sts=conn.createStatement();
int sno = Integer.parseInt(request.getParameter("sno"));
String sql="delete from save where s_no="+sno+"";
if (sts.executeUpdate(sql) == 1) {
%>
<p>删除成功</p>
<% session.sendRedirect("saveQuery.jsp"); %>
<% } else { %>
<p>删除失败</p>
<% } %>
</html>
