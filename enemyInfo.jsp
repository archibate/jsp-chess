<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");

PreparedStatement stmt;

stmt = conn.prepareStatement(
"select r_owner, r_guest, r_ownerColor from room where r_owner = ?"
);
stmt.setInt(1, roomId);
ResultSet rs = stmt.executeQuery();

if (!rs.next()) {
    out.print("ERROR: 找不到房间");
    return;
}

int enemyUid = -1;
if (myColor.equals(rs.getString("r_ownerColor"))) {
    if (rs.getObject("r_guest") != null && !rs.wasNull()) {
        enemyUid = rs.getInt("r_guest");
    } else {
        out.print("NONE");
        return;
    }
} else {
    enemyUid = rs.getInt("r_owner");
}

stmt = conn.prepareStatement(
"select u_name from user where u_no = ?"
);
stmt.setInt(1, enemyUid);
rs = stmt.executeQuery();

if (!rs.next()) {
    out.print("ERROR: 找不到对手");
    return;
}

String enemyName = rs.getString("u_name");
out.print("OK:" + enemyName);

%>
