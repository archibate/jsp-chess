<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
String myColor = request.getParameter("myColor");

PreparedStatement stmt = conn.prepareStatement(
"replace into room (r_owner, r_ownerColor) values (?, ?)"
);
stmt.setInt(1, uid);
stmt.setString(2, myColor);
stmt.executeUpdate();
int roomId = uid;
session.setAttribute("roomId", roomId);
session.setAttribute("myColor", "");
out.print("OK:" + roomId);
%>
