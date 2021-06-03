<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>中国象棋对战系统登录页面</title>
<meta name="description" content="Custom Login Form Styling with CSS3" />
<meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico"> 
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/modernizr.custom.63321.js"></script>
<!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
</head>
<body>
<div id="Layer" style="position:absolute; left:0px; top:0px; width:100%; height:100%">
<img src="ChessBoard.jpg" width="100%" height="100%"/>
</div>

<center>
    


        <form class="form-4"  action="LoginHandle.jsp" method="post">
		        <h1><font color=white>中  国  象  棋  对  战  系  统</font></h1>
		<br/>
		<br/>
		<br/>
		<h2><font color=white>欢 迎 登 录</font></h2>
		<br/>
            <p>
                <input type="text" name="Username" placeholder="用户名" required>
            </p>
            <p>
                <input type="text" name="Password" placeholder="密码" required> 
            </p>
                <a href="SearchPasswordFace.html"><font size="1px" color=white><u>忘记密码</u></font></a>
            <p>
			<br/>
                <input type="submit" name="submit" value="登   录">
            </p>   
			<br/>
                <a href="RegisterFace.html"><u><font color=white size="1px">若无账号，点击此处注册</font></u></a> 		
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			    <a href="Administrator.html"><font color=white size="1px">后台管理</font></a>
			<br/>
			<font color=white size="1px">Copyright © 2021 中国象棋对战平台 | <a href="http://www.gench.edu.cn">上海建桥学院</a></font>
        </form>​
		
</center>
</body>
</html>
