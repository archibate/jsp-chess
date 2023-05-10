<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");
String data = (String)request.getParameter("data");
String title = (String)request.getParameter("title");
PreparedStatement stmt;

stmt = conn.prepareStatement(
"select r_state, r_color, r_steps from room where r_owner = ?"
);
stmt.setInt(1, roomId);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    data = rs.getString(1);
    String nowColor = rs.getString(2);
    int steps = rs.getInt(3);
    stmt = conn.prepareStatement(
    "insert into save (s_owner, s_ownerColor, s_color, s_state, s_steps, s_title) values (?, ?, ?, ?, ?, ?)"
    );
    stmt.setInt(1, uid);
    stmt.setString(2, myColor);
    stmt.setString(3, nowColor);
    stmt.setString(4, data);
    stmt.setInt(5, steps);
    stmt.setString(6, title);
    stmt.executeUpdate();
    out.print("OK");
} else {
    out.print("ERROR");
}

%>
