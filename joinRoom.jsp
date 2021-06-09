<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int roomId = Integer.parseInt(request.getParameter("roomId"));

if (roomId == uid) {
    out.print("不能加入自己创建的房间！");

} else {
    PreparedStatement stmt = conn.prepareStatement(
    "update room set r_guest = ? where r_owner = ? and isnull(r_guest)"
    );
    stmt.setInt(1, uid);
    stmt.setInt(2, roomId);
    stmt.executeUpdate();
    if (stmt.getUpdateCount() != 1) {
        out.print("找不到房间或已经有人加入");
    } else {
        session.setAttribute("roomId", roomId);
        session.setAttribute("myColor", "");
        out.print("OK:" + roomId);
    }
}
%>
