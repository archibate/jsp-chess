<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");

PreparedStatement stmt = conn.prepareStatement(
"select m_seq, m_srcXY, m_dstXY from motion where m_room = ? and m_color != ?"
);
stmt.setInt(1, roomId);
stmt.setString(2, myColor);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    int motionId = rs.getInt(1);
    int srcXY = rs.getInt(2);
    int dstXY = rs.getInt(3);
    out.println("M" + srcXY + "" + dstXY);
    stmt = conn.prepareStatement(
    "delete from motion where m_room = ? and m_seq = ?"
    );
    stmt.setInt(1, roomId);
    stmt.setInt(2, motionId);
    stmt.executeUpdate();
} else {
    out.println("NONE");
}
%>
