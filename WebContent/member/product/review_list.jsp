<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../../layout/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../../css/review_style.css">
	
	<div align = "center">
	<br>
		<h3>배송이 완료된 상품만 리뷰를 작성할 수 있습니다.</h3>
	<br>
	<table id = 'review_list_table'>
		<tr id = 'review_list_title_line' height = 50>
			<td width = 100></td>
			<td width = 300>상품정보</td>
			<td width = 200>구매일</td>
			<td width = 100>후기 작성</td>
		</tr>
<%
try {
	String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
	String DB_ID = "aqua";
	String DB_PASSWORD = "1234";

	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	String state = "배송완료";
	String jsql = "select * from order_info where m_id = ? AND ord_state = ?";
	PreparedStatement pstmt = con.prepareStatement(jsql);
	pstmt.setString(1, sid);
	pstmt.setString(2, state);
	ResultSet rs = pstmt.executeQuery();
	
	
	while (rs.next()) {
		
		String ord_date = rs.getString("ord_date");
		int ord_no = rs.getInt("ord_no");
		String jsql2 = "select p_id from order_product where ord_no = ?";
		PreparedStatement pstmt2 = con.prepareStatement(jsql2);
		pstmt2.setInt(1, ord_no);
		ResultSet rs2 = pstmt2.executeQuery();
		
		while (rs2.next()){
			String p_id = rs2.getString("p_id");
			
			String jsql3 = "select p_name from product where p_id = ?";
			PreparedStatement pstmt3 = con.prepareStatement(jsql3);
			pstmt3.setString(1, p_id);
			ResultSet rs3 = pstmt3.executeQuery();
			
			String jsql4 = "select t_name from ticket where t_id = ?";
			PreparedStatement pstmt4 = con.prepareStatement(jsql4);
			pstmt4.setString(1, p_id);
			ResultSet rs4 = pstmt4.executeQuery();
			
			while(rs3.next()){
				String p_name = rs3.getString("p_name");
				%>
				
				<tr id = 'review_list_content_line' height = 130>
					<td>
						<a>
							<img src="../../img/product/<%=p_id%>.jpg" border=0 width=80px
						height=96px>
						</a>
					</td>
					<td>
						<a>
							<%= p_name %>
						</a>
					</td>
					<td style = "text-align : center;">
						<a>
							<%=ord_date%>
						</a>
					</td>
					<td id = 'review_write_btn'>
						<button type="button" class="buy-btn" onclick="need_login();">작성하기</button>
					</td>
				</tr>
				<%
			}
			while(rs4.next()){
					String t_name = rs4.getString("t_name");
					
					%>
					
					<tr id = 'review_list_content_line' height = 130>
						<td>
							<a>
								<img src="../../img/tickets/<%=p_id%>.jpg" border=0 width=80px
							height=96px>
							</a>
						</td>
						<td>
							<a>
								<%= t_name %>
							</a>
						</td>
						<td style = "text-align : center;">
							<a>
								<%= ord_date %>
							</a>
						</td>
						<td id = 'review_write_btn'>
						<button type="button" class="buy-btn" onclick="need_login();">작성하기</button>
					</td>
					</tr>
					<%
			}
		}
	}
%>
</table>
<%
}catch (Exception e) {
	out.println("구매한 상품이 없습니다.");
}
%>
	</div>
</body>
<%@ include file="../../layout/footer.jsp"%>
<script type="text/javascript" src="../../js/review.js"></script>
</html>