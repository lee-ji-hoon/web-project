<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../../layout/header.jsp"%>

<%
		try
{
		String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
		String DB_ID = "aqua";
		String DB_PASSWORD = "1234";
		
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		
		
		String jsql2 = "SELECT * FROM temp_recent WHERE m_id=?";
		PreparedStatement pstmt2 = con.prepareStatement(jsql2);
		pstmt2.setString(1,sid);
		ResultSet rs2  = pstmt2.executeQuery();
		 %>
		 
		 <%
		 while(rs2.next()){
			 String m_id = rs2.getString("m_id");
			 String p_id = rs2.getString("p_id");
			 String p_name = rs2.getString("p_name");
			 String recent_date = rs2.getString("recent_date");
		 %>
		 	<li><%=m_id %></li>
		 	<li><%=p_id %></li>
		 	<li><%=p_name %></li>
		 	<li><%=recent_date %></li>
		 <%
		 }
		 %>
		 
<%
} catch (Exception e) {
out.println(e);
}
%>
</body>
<%@ include file="../../layout/footer.jsp"%>
</html>