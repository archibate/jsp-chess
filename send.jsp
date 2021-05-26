<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
String data = request.getParameter("data");
int srcX = data.charAt(1) - '0';
int srcY = data.charAt(2) - '0';
int dstX = data.charAt(3) - '0';
int dstY = data.charAt(4) - '0';
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");

PreparedStatement stmt = conn.prepareStatement(
"update room set r_color = ? where r_no = ? and r_color = ?"
);
stmt.setString(1, myColor.equals("red") ? "black" : "red");
stmt.setInt(2, roomId);
stmt.setString(3, myColor);
stmt.executeUpdate();
if (stmt.getUpdateCount() != 1) {
    out.println("NOT_YOUR_TURN");
} else {
    stmt = conn.prepareStatement(
    "insert into motion (m_room, m_color, m_srcXY, m_dstXY) values (?, ?, ?, ?)"
    );
    stmt.setInt(1, roomId);
    stmt.setString(2, myColor);
    stmt.setInt(3, srcX * 10 + srcY);
    stmt.setInt(4, dstX * 10 + dstY);
    stmt.executeUpdate();
    if (stmt.getUpdateCount() == 1) {
        out.println("OK");
    } else {
        out.println("ERROR");
    }
}
%>
