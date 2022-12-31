<%@ page language="java" import="java.util.*, java.sql.*, java.io.*" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<%
int uid = (int)session.getAttribute("uid");
int roomId = (int)session.getAttribute("roomId");
String myColor = (String)session.getAttribute("myColor");
String data = request.getParameter("data");
PreparedStatement stmt;

stmt = conn.prepareStatement(
"select r_guest, r_state from room where r_owner = ? and r_color = ?"
);
stmt.setInt(1, roomId);
stmt.setString(2, myColor);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    int guestId = rs.getInt(1);
    String oldData = rs.getString(2);
    String nextColor = myColor;

    if (data.length() != 0) {
        if (guestId <= -1) {
            String aiRep;
            String aiAsk = (myColor.equals("red") ? "B" : "R") + data;

            String[] cmdArr = {application.getRealPath("/") + "ChessAI", aiAsk};
            Process proc = Runtime.getRuntime().exec(cmdArr);
            java.io.BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            char[] readBuf = new char[65];
            int readLen = reader.read(readBuf);
            if (readLen == -1) {
                aiRep = "ERRORPIPE";
            } else {
                aiRep = new String(readBuf);
                aiRep = aiRep.substring(0, readLen);
            }
            reader.close();

            if (!(aiRep.length() != 0 && aiRep.charAt(0) == 'M' && aiRep.length() >= 65)) {
                out.print("ERROR: AI 大脑未响应 (" + aiRep + ")");
                return;
            }
            data = aiRep.substring(1);
        } else {
            nextColor = myColor.equals("red") ? "black" : "red";
        }

        stmt = conn.prepareStatement(
        "update room set r_color = ?, r_state = ?, r_steps = r_steps + 1 where r_owner = ? and r_color = ?"
        );
        stmt.setString(1, nextColor);
        stmt.setString(2, data);
        stmt.setInt(3, roomId);
        stmt.setString(4, myColor);
        stmt.executeUpdate();

    }

    out.print(data.length() != 0 ? "Y" : "N");
    out.print(data.length() != 0 ? data : oldData);
}

%>
