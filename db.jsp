<%
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/letterdb", "root", "ihatesql");
/*
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://" + System.getenv("MYSQL_ADDR") + ":3306/letterdb", "root", "ihatesql");
*/
%>
