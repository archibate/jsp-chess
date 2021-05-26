<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int roomId = 1;
String myColor = request.getParameter("myColor");
session.setAttribute("roomId", roomId);
session.setAttribute("myColor", myColor);

out.println("roomId: " + roomId);
out.println("myColor: " + myColor);
%>
