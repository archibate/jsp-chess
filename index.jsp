<!DOCTYPE html>
<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="db.jsp"%>
<html>
<head lang="zh-cn">
    <meta charset="UTF-8">
    <title>中国象棋 | 首页</title>
    <link rel="shortcut icon" href="../favicon.ico"> 
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script src="js/modernizr.custom.63321.js"></script>
    <!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
</head>
<body>
    <div id="Layer" style="position:absolute; left:0px; top:0px; width:100%; height:100%">
     <img src="BambooPlus.jpg" width="100%" height="100%"/>
    </div>
  <center>
<form class="form-4">
            </p>
                <h1><font size="10px">用  户  首  页</font></a></h1>
            <p>
			<br/>
<%
if (session.getAttribute("uid") == null) {
    response.sendRedirect("login.html");
    return;
}

int uid = (int)session.getAttribute("uid");

PreparedStatement stmt = conn.prepareStatement(
"select u_name, u_point, u_round from user where u_no = ?"
);
stmt.setInt(1, uid);
ResultSet rs = stmt.executeQuery();
if (rs.next()) {
    String username = rs.getString(1);
    int point = rs.getInt(2);
    int round = rs.getInt(3);
    %>
    <table>
    <tr> <td>用户编号</td> <td><% out.print(uid); %></td> </tr>
    <tr> <td>用户名</td> <td><% out.print(username); %></td> </tr>
    <tr> <td>积分点数</td> <td><% out.print(point); %></td> </tr>
    <tr> <td>总局数</td> <td><% out.print(round); %></td> </tr>
    </table>
    <%
} else {
    %>
    <span color="red">未登录<span>
    <%
}
%><br/>
			<br/>
			<br/>
            </p>
                <h2><a href="register.html"><font size="6px">用 户 注 册</font></a></h2>
            <p>
			<br/>
			<br/>
			</p>
                <h3><a href="login.html"><font size="6px">用 户 登 录</font></a></h3>
            <p>
			<br/>
			<br/>
			</p>
                <h4><a href="SessionLogout.jsp"><font size="6px">退 出 登 录</font></a></h4>
            <p>
			<br/>

            <hr/>

			<br/>
			</p>
                <h5><a href="joinRoom.html"><font size="6px">加 入 房 间</font></a></h5>
            <p>
			<br/>
			<br/>
			</p>
                <h5><a href="newRoom.html"><font size="6px">创 建 房 间</font></a></h5>
            <p>
			<br/>
			<br/>
			</p>
                <h5><a href="chess.html"><font size="6px">当 前 对 战</font></a></h5>
            <p>
			<br/>
			<br/>
			<br/>
			</p>
            <p>
			
  </center>
  </body>
</html>

<a href="register.html">用户注册</a>
<a href="login.html">用户登录</a>
<a href="SessionLogout.html">退出登录</a>
|
<a href="joinRoom.html">加入房间</a>
<a href="newRoom.html">创建房间</a>
<a href="chess.html">当前对战</a>

</script>

</body>
</html>

