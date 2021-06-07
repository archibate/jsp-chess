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
    out.print("ERROR0");
}

int enemyUid = -1;
if (myColor.equals(rs.getString("r_ownerColor"))) {
    enemyUid = rs.getInt("r_guest");
} else {
    enemyUid = rs.getInt("r_owner");
}

stmt = conn.prepareStatement(
"delete from room where r_owner = ?"
);
stmt.setInt(1, roomId);
stmt.executeUpdate();

if (stmt.getUpdateCount() != 1) {
    out.print("ERROR1");
    return;
}

stmt = conn.prepareStatement(
"update user set u_round = u_round + 1 where u_no = ?"
);
stmt.setInt(1, uid);
stmt.executeUpdate();

if (stmt.getUpdateCount() != 1) {
    out.print("ERROR2");
    return;
}

stmt = conn.prepareStatement(
"update user set u_point = u_point + 1, u_round = u_round + 1 where u_no = ?"
);
stmt.setInt(1, enemyUid);
stmt.executeUpdate();

if (stmt.getUpdateCount() != 1) {
    out.print("ERROR3");
    return;
}

out.print("OK");

%>
