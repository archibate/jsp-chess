<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int sno = Integer.parseInt(request.getParameter("sno"));
PreparedStatement stmt = conn.prepareStatement(
"select s_state, s_ownerColor, s_color from save where s_no = ? and s_owner = ?"
);
stmt.setInt(1, sno);
stmt.setInt(2, uid);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
String state = rs.getString(1);
String myColor = rs.getString(2);
String nowColor = rs.getString(3);

stmt = conn.prepareStatement(
"replace into room (r_owner, r_ownerColor, r_color, r_state) values (?, ?, ?, ?)"
);
stmt.setInt(1, uid);
stmt.setString(2, myColor);
stmt.setString(3, nowColor);
stmt.setString(4, state);
stmt.executeUpdate();
int roomId = uid;
session.setAttribute("roomId", roomId);
session.setAttribute("myColor", "");
response.sendRedirect("chess.html");
%>
<p>正在跳转到房间<% out.print(roomId); %>...</p>
<% } else { %>
<p>错误：存档不存在</p>
<% } %>
