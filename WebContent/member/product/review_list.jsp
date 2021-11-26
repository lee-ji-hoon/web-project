<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../../layout/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="../../css/review_style.css?aa">
	
	<div align = "center">
	<br>
		<h1>공사중</h3>
		<h2>티켓 / 상품 구분지어서 리뷰를 볼 수 있도록 작성</h3>
		<h3>티켓 : 구분 없이 리뷰 출력</h3>
		<h4>상품 : 각 품목별 리뷰 출력</h3>
	<br>
	
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
	
}catch (Exception e) {
	out.println("구매한 상품이 없습니다.");
}
%>
	</div>
</body>
<%@ include file="../../layout/footer.jsp"%>
<script type="text/javascript" src="../../js/review.js"></script>
</html>