<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
String data = request.getParameter("data");
int srcX = data.charAt(1) - '0';
int srcY = data.charAt(2) - '0';
int dstX = data.charAt(3) - '0';
int dstY = data.charAt(4) - '0';
int roomId = 1;

PreparedStatement stmt = conn.prepareStatement("call moveChess(?, ?, ?)");
stmt.setInt(1, srcX * 10 + srcY);
stmt.setInt(2, dstX * 10 + dstY);
stmt.setInt(3, roomId);
stmt.executeUpdate();
%>
