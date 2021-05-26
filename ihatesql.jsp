<%
  Class.forName("org.mariadb.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/letterdb", "root", "ihatesql");
%>
