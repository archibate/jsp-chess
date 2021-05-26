<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
String data = request.getParameter("data");
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");

if (data.length) {
    PreparedStatement stmt = conn.prepareStatement(
    "update room set r_color = ?, r_state = ? where r_no = ? and r_color = ?"
    );
    stmt.setString(1, myColor.equals("red") ? "black" : "red");
    stmt.setString(2, data);
    stmt.setInt(3, roomId);
    stmt.setString(4, myColor);
    stmt.executeUpdate();
}

PreparedStatement stmt = conn.prepareStatement(
"select r_state from room where r_no = ?"
);
stmt.setInt(1, roomId);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    String data = rs.getString(1);
    out.print(data);
}

%>
