<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../layout/header_manager.jsp"%>
<link rel="stylesheet" type="text/css" href="../../css/style-table.css?v=123">
<html>
<head>
<title>상품 등록 처리 결과</title>
</head>
<body>

	<%
	request.setCharacterEncoding("utf-8"); // 입력폼에서 전송된 한글데이터 처리

	// 입력폼에서 받는 데이터는 모두 String형임
	String p_id = request.getParameter("id");
	String p_name = request.getParameter("name");
	int p_price = Integer.parseInt(request.getParameter("price"));
	int p_stock = Integer.parseInt(request.getParameter("stock"));
	String p_category = request.getParameter("ctg");
	String p_description = request.getParameter("description");

	String[] p_option = request.getParameterValues("option");
	String p_option_list = " ";
	if (p_option != null) {
		for (int i = 0; i < p_option.length; i++) {
			p_option_list += p_option[i];
			p_option_list += "  ";
		}
	} else
		p_option_list = "옵션 없음";

	try {
		String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
		String DB_ID = "aqua";
		String DB_PASSWORD = "1234";

		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		String jsql = "INSERT INTO product  (p_id, p_name, p_price, p_stock, p_category, p_description, p_option) VALUES  (?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, p_id);
		pstmt.setString(2, p_name);
		pstmt.setInt(3, p_price);
		pstmt.setInt(4, p_stock);
		pstmt.setString(5, p_category);
		pstmt.setString(6, p_description);
		pstmt.setString(7, p_option_list);
		pstmt.executeUpdate();
	%>
	<center>
		<font color="" size='6'>
			<b>[등록된 상품 정보]</b>
		</font>
		<p>
		<table border="2" cellpadding="10" style="font-size: 10pt; font-family: 맑은 고딕">
			<tr>
				<th>상품 아이디</th>
				<td><%=p_id%></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><%=p_name%></td>
			</tr>
			<tr>
				<th>상품가격</th>
				<td><%=p_price%>
					원
				</td>
			</tr>
			<tr>
				<th>재고수량</th>
				<td><%=p_stock%>
					개
				</td>
			</tr>
			<tr>
				<th>카테고리 분류</th>
				<td><%=p_category%></td>
			</tr>
			<tr>
				<th>옵션</th>
				<td><%=p_option_list%></td>
			</tr>
			<tr>
				<th>상품설명</th>
				<td><%=p_description%></td>
			</tr>
		</table>
		<p>
			<%
			} catch (Exception e) {
			out.println(e);
			}
			%>
		
		<p>
			<a href="manager_product_select.jsp" style="font-size: 10pt; font-family: 맑은 고딕">전체 등록상품 조회</a>
			<br>
			<br>
	</center>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>