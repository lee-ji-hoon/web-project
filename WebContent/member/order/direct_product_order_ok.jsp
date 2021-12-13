<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../layout/header.jsp"%>


<%@ page import="java.sql.*"%>


<%
try {
	String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
	String DB_ID = "aqua";
	String DB_PASSWORD = "1234";

	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	request.setCharacterEncoding("utf-8");
	
	String jsql0 = "SET SQL_SAFE_UPDATES = 0";
	PreparedStatement pstmt0 = con.prepareStatement(jsql0);
	ResultSet rs0 = pstmt0.executeQuery();

	String ct_no = session.getId(); 
	String oName = request.getParameter("name");
	String oTel = request.getParameter("memTel");
	String oReceiver = request.getParameter("receiver");
	String oRcvAddress = request.getParameter("rcvAddress");
	String oRcvPhone = request.getParameter("rcvPhone");
	String oCardNo = request.getParameter("cardNo");
	String oCardPass = request.getParameter("cardPass");
	String oBank = request.getParameter("bank");
	String oPay = request.getParameter("pay");

	String jsql = "select MAX(ord_no) from order_info order by ord_no";
	PreparedStatement pstmt = con.prepareStatement(jsql);

	ResultSet rs = pstmt.executeQuery();

	int o_num;
	if (rs.next()) 
		o_num = rs.getInt(1) + 1;
							
	else
		o_num = 1; 

	String jsql2 = "select p_id, ct_qty from temp_cart where ct_no = ?";
	PreparedStatement pstmt2 = con.prepareStatement(jsql2);
	pstmt2.setString(1, ct_no);

	ResultSet rs2 = pstmt2.executeQuery();

	
	while (rs2.next()) 
	{ 
		String p_id = rs2.getString("p_id");
		int ct_qty = rs2.getInt("ct_qty");

		String jsql3 = "INSERT INTO order_product (ord_no, p_id, ord_qty) VALUES (?,?,?)";
		PreparedStatement pstmt3 = con.prepareStatement(jsql3);
		pstmt3.setString(1, Integer.toString(o_num));
		pstmt3.setString(2, p_id);
		pstmt3.setInt(3, ct_qty);

		pstmt3.executeUpdate();
		
		String jsql4 = "UPDATE product SET p_stock = p_stock - ? WHERE p_id = ? ";
		PreparedStatement pstmt4 = con.prepareStatement(jsql4);
		pstmt4.setInt(1, ct_qty);
		pstmt4.setString(2, p_id);
		pstmt4.executeUpdate();
	}
	String jsql7 = "INSERT INTO order_info (ord_no, m_id, ord_date, ord_receiver, ord_rcv_address, ord_rcv_phone, ord_pay, ord_bank, ord_card_no, ord_card_pass)  VALUES(?,?,?,?,?,?,?,?,?,?)";
	java.util.Date date = new java.util.Date();
	String oDate = date.toLocaleString();

	PreparedStatement pstmt7= con.prepareStatement(jsql7);
	pstmt7.setString(1, Integer.toString(o_num));
	pstmt7.setString(2, sid);
	pstmt7.setString(3, oDate);
	pstmt7.setString(4, oReceiver);
	pstmt7.setString(5, oRcvAddress);
	pstmt7.setString(6, oRcvPhone);
	pstmt7.setString(7, oPay);
	pstmt7.setString(8, oBank);
	pstmt7.setString(9, oCardNo);
	pstmt7.setString(10, oCardPass);

	pstmt7.executeUpdate();

	response.sendRedirect("direct_product_order_delete.jsp");

} catch (Exception e) {
	out.println(e);
}
%>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>
