<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");

PreparedStatement stmt = conn.prepareStatement(
"select r_state from room where r_no = ?"
);
stmt.setInt(1, roomId);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    String data = rs.getString(1);
    out.print(data);
} else {
    out.print("ROOM_NOT_FOUND");
}
%>
