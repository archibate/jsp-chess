<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");
String data = request.getParameter("data");
PreparedStatement stmt;

if (data.length() != 0) {
    stmt = conn.prepareStatement(
    "update room set r_color = ?, r_state = ? where r_owner = ? and r_color = ?"
    );
    stmt.setString(1, myColor.equals("red") ? "black" : "red");
    stmt.setString(2, data);
    stmt.setInt(3, roomId);
    stmt.setString(4, myColor);
    stmt.executeUpdate();
}

stmt = conn.prepareStatement(
"select r_state, r_color from room where r_owner = ?"
);
stmt.setInt(1, roomId);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    data = rs.getString(1);
    String nowColor = rs.getString(2);
    out.print(!nowColor.equals(myColor) ? "Y" : "N");
    out.print(data);
}

%>
