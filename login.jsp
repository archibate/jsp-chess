<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");

PreparedStatement stmt = conn.prepareStatement(
"select u_no from user where u_name = ? and u_passwd = ?"
);
stmt.setString(1, username);
stmt.setString(2, password);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    int uid = rs.getInt(1);
    session.setAttribute("uid", uid);
    out.print("OK:" + uid);
} else {
    out.print("ERROR");
}
%>
