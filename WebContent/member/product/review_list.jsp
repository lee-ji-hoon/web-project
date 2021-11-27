<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../layout/header.jsp"%>
<link rel = "stylesheet" href = "../../css/review_style.css?a">
	
	<!--<body> -> header.jsp에 있음-->
	<div align="center">

		

			<%
			try {
				String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
				String DB_ID = "aqua";
				String DB_PASSWORD = "1234";
				
				String t_id = request.getParameter("t_id");
				String p_id = request.getParameter("p_id");
				
				Class.forName("org.gjt.mm.mysql.Driver");
				Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

				String jsql = "SELECT * FROM product where p_id = ?";
				PreparedStatement pstmt = con.prepareStatement(jsql);
				pstmt.setString(1, p_id);
				ResultSet rs = pstmt.executeQuery();

				String jsql2 = "SELECT * FROM ticket where t_id = ?";
				PreparedStatement pstmt2 = con.prepareStatement(jsql2);
				pstmt2.setString(1, t_id);
				ResultSet rs2 = pstmt2.executeQuery();
			%>
				<table id = 'review_list_table' border="0" style="font-size: 10pt; font-family: 맑은 고딕; table-layout:fixed">
					<tr id = 'review_t_list_title_line' height = 30>
						<td width="100">작성일</td>
						<td width="100">작성자</td>
						<td width="100">상품 이름</td>
						<td width="100">배송 만족도</td>
						<td width="100">상품 만족도</td>
						<td width="300">후기 내용</td>
					</tr>
			<%
				if(rs.next()){
					String p_name = rs.getString("p_name");
					String p_id2 = rs.getString("p_id");
					
					String jsql3 = "SELECT * FROM review where r_product = ?";
					PreparedStatement pstmt3 = con.prepareStatement(jsql3);
					pstmt3.setString(1, p_name);
					ResultSet rs3 = pstmt3.executeQuery();
					
					while(rs3.next()){
						String r_writer = rs3.getString("r_writer");
						String r_product = rs3.getString("r_product");
						String r_date = rs3.getString("r_date");
						String d_satisfy = rs3.getString("d_satisfy");
						String p_satisfy = rs3.getString("p_satisfy");
						String r_content = rs3.getString("r_content");
					
			%>
						<tr id = 'review_t_list_content_line'>
							<td>
								<%=r_date%>
							</td>
							<td>
								<%=r_writer%>
							</td>
							<td>
								<%=r_product%>
							</td>
							<td>
								<%=d_satisfy%>
							</td>
							<td>
								<%=p_satisfy%>
							</td>
							<td style=" text-overflow:ellipsis; overflow:hidden">
								<%=r_content%>
							</td>
						</tr>
			<%
					}
				}
				else{
					%>
					<tr id = 'review_t_list_title_line' height = 30>
						<td width="100">작성일</td>
						<td width="100">작성자</td>
						<td width="100">상품 이름</td>
						<td width="100">e-티켓 만족도</td>
						<td width="100">현장 만족도</td>
						<td width="300">후기 내용</td>
					</tr>
				<%
					rs2.next();
					String t_name = rs2.getString("t_name");
					String t_id2 = rs2.getString("t_id");
					
					String jsql3 = "SELECT * FROM review where r_product = ?";
					PreparedStatement pstmt3 = con.prepareStatement(jsql3);
					pstmt3.setString(1, t_name);
					ResultSet rs3 = pstmt3.executeQuery();
					
					while(rs3.next()){
						String r_writer = rs3.getString("r_writer");
						String r_product = rs3.getString("r_product");
						String r_date = rs3.getString("r_date");
						String d_satisfy = rs3.getString("d_satisfy");
						String p_satisfy = rs3.getString("p_satisfy");
						String r_content = rs3.getString("r_content");
					
			%>
						<tr id = 'abu_notice_list'>
							<td align="center" width = 100>
								<%=r_date%>
							</td>
							<td align="center" width = 150>
								<%=r_writer%>
							</td>
							<td align="left" width = 100 height = 100 >
								<%=r_product%>
							</td>
							<td align="right" width = 100 height = 100>
								<%=d_satisfy%>
							</td>
							<td align="right" width = 100 height = 100>
								<%=p_satisfy%>
							</td>
							<td align="right" width = 500 height = 100 style=" text-overflow:ellipsis; overflow:hidden">
								<%=r_content%>
							</td>
						</tr>
					<%
				}
				}
					%>
					</table>
					<%
    } catch (Exception e) {
      out.println(e);	
}
%>
		
	</div>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>