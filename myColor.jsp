<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
if (session.getAttribute("roomId") == null) {
    out.print("ERROR");
    return;
}
int roomId = (int)session.getAttribute("roomId");

PreparedStatement stmt = conn.prepareStatement(
"select r_owner, r_ownerColor from room where r_owner = ?"
);
stmt.setInt(1, roomId);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    int owner = rs.getInt(1);
    String color = rs.getString(2);
    if (owner != uid)
        color = color.equals("red") ? "black" : "red";
    session.setAttribute("myColor", color);
    out.print(roomId + ":" + color);
} else {
    out.print("ERROR");
}
%>
