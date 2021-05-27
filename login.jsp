<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = Integer.parseInt(request.getParameter("uid"));
session.setAttribute("uid", uid);
out.print("OK:" + uid);
%>
