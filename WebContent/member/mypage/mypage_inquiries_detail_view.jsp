<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../layout/header.jsp"%>\
<link rel = "stylesheet" href = "../css/about_us_style.css?after">

<!--<body> -> header.jsp에 있음-->
	<div align="center">
		<h3> QnA </h3>

		<table style="font-size: 10pt; font-family: 맑은 고딕; table-layout:fixed">
			<%
			try {
				String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
				String DB_ID = "aqua";
				String DB_PASSWORD = "1234";

				Class.forName("org.gjt.mm.mysql.Driver");
				Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
				
				String key = request.getParameter("qna_no");

				String jsql = "SELECT * FROM qna, qna_answer where qna_no = ? and qna_ref_no = ?";
				PreparedStatement pstmt = con.prepareStatement(jsql);
				pstmt.setString(1, key);
				pstmt.setString(2, key);
				ResultSet rs = pstmt.executeQuery();
				
				rs.next();
				int qna_no = rs.getInt("qna_no");
			   	String qna_category = rs.getString("qna_category");
				Date qna_date = rs.getDate("qna_date");
				String qna_title = rs.getString("qna_title");
				String qna_content = rs.getString("qna_content");
				String qna_comment = rs.getString("qna_comment");
				String qna_comment_date = rs.getString("qna_comment_date");
				String manager_id = rs.getString("manager_id");
			%>
			<tr id = 'qna_title_line'>
				<td align=center width = 100 height = 50 style = "color:#555;"><%=qna_category %></td>
				<td align=left width = 500 height = 50 colspan='2' style = "font-weight:bold">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=qna_title%> </td>
			</tr>
			<tr>
				<td align="center" colspan='3' style = "padding-top : 10px">
					<%=qna_content%>
				</td>
			</tr>
			<tr id = 'qna_detail_title'>
				<td align=center width = 100 height = 50 style = "color:#555;"><%=qna_comment_date %></td>
				<td align=left width = 100 height = 50 style = "font-weight:bold"><%=manager_id%> </td>
				<td align=left width = 400 height = 50><%=qna_comment%> </td>
			</tr>
			
		</table>
		<%
    	} catch (Exception e) {
		%>
		<table style="font-size: 10pt; font-family: 맑은 고딕; table-layout:fixed">
			<%
				String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
				String DB_ID = "aqua";
				String DB_PASSWORD = "1234";

				Class.forName("org.gjt.mm.mysql.Driver");
				Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
				
				String key = request.getParameter("qna_no");

				String jsql2 = "SELECT * FROM qna where qna_no = ?";
				PreparedStatement pstmt2 = con.prepareStatement(jsql2);
				pstmt2.setString(1, key);
				ResultSet rs2 = pstmt2.executeQuery();
				
				rs2.next();
				int qna_no = rs2.getInt("qna_no");
			   	String qna_category = rs2.getString("qna_category");
				Date qna_date = rs2.getDate("qna_date");
				String qna_title = rs2.getString("qna_title");
				String qna_content = rs2.getString("qna_content");
			%>
			<tr id = 'qna_title_line'>
				<td align=center width = 100 height = 50 style = "color:#555;"><%=qna_category %></td>
				<td align=left width = 500 height = 50 colspan='2' style = "font-weight:bold">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=qna_title%> </td>
			</tr>
			<tr>
				<td align="center" colspan='3' style = "padding-top : 10px">
					<%=qna_content%>
				</td>
			</tr>
			<tr id = 'qna_detail_title'>
				<td align=center width = 100 height = 50 colspan="3" style = "color:#555;"><b>등록된 답변이 없습니다.</b></td>
			</tr>
			
		</table>
		<%
		}
		%>
	</div>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>