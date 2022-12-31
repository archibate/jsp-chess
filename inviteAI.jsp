<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
if (session.getAttribute("roomId") == null) {
    out.print("ERROR");
    return;
}
int roomId = (int)session.getAttribute("roomId");

int aiUid = -1;
PreparedStatement stmt = conn.prepareStatement(
"update room set r_guest = ? where r_owner = ? and isnull(r_guest)"
);
stmt.setInt(1, aiUid);
stmt.setInt(2, roomId);
stmt.executeUpdate();
if (stmt.getUpdateCount() != 1) {
out.print("找不到房间或已经有人加入");
} else {
out.print("OK");
}
%>
