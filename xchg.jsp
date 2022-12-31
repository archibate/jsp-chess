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

    if (data.length() != 0) {
        if (guestId <= -1) {
            String aiAsk = (myColor.equals("red") ? "B" : "R") + data;
            Process proc = Runtime.getRuntime().exec("AI/build/ChessAI");
            java.io.BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(proc.getOutputStream()));
            java.io.BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            writer.write(aiAsk);
            writer.close();
            char[] buf = new char[65];
            reader.read(buf);
            String aiRep = new String(buf);
            reader.close();

            if (!(aiRep.length() != 0 && aiRep.charAt(0) == 'M' && aiRep.length() >= 65)) {
                out.print("ERROR: AI 大脑未响应");
                return;
            }
            data = aiRep.substring(1);
        }

        stmt = conn.prepareStatement(
        "update room set r_color = ?, r_state = ?, r_steps = r_steps + 1 where r_owner = ? and r_color = ?"
        );
        stmt.setString(1, myColor.equals("red") ? "black" : "red");
        stmt.setString(2, data);
        stmt.setInt(3, roomId);
        stmt.setString(4, myColor);
        stmt.executeUpdate();

    }

    out.print(data.length() != 0 ? "Y" : "N");
    out.print(data.length() != 0 ? data : oldData);
}

%>
