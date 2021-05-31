<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
int age = Integer.parseInt(request.getParameter("age"));
String sex = request.getParameter("sex");

PreparedStatement stmt = conn.prepareStatement(
"insert into user (u_name, u_passwd, u_age, u_sex) values (?, ?, ?, ?)"
);
stmt.setString(1, username);
stmt.setString(2, password);
stmt.setInt(3, age);
stmt.setString(4, sex);
stmt.executeUpdate();
if (stmt.getUpdateCount() == 1) {
    out.print("OK");
} else {
    out.print("ERROR");
}
%>
