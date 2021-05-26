<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");

out.print(myColor);
%>
