<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int roomId = request.getParameter("roomId");

PreparedStatement stmt = conn.prepareStatement(
"update room set r_guest = ? where r_owner = ?"
);
stmt.setInt(1, uid);
stmt.setString(2, roomId);
stmt.executeUpdate();
if (stmt.getUpdateCount() != 1) {
    out.print("ERROR");
} else {
    session.setAttribute("roomId", roomId);
    out.print(roomId);
}
%>
