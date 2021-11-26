
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../../layout/header.jsp"%>
<html><head><title>주문 완료 or  장바구니내용 삭제</title></head>
<body>

<%
try {
	String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
	String DB_ID = "aqua";
	String DB_PASSWORD = "1234";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

	String ct_no = session.getId();   //  세션번호(장바구니번호)를 가져옴
	String case_no = request.getParameter("case");

	String jsql = "delete from cart where ct_no=?";   
	PreparedStatement pstmt = con.prepareStatement(jsql);
	pstmt.setString(1, ct_no);
	
    pstmt.executeUpdate();
    
    String jsql2 = "delete from cart_t where ct_no=?";   
	PreparedStatement pstmt2 = con.prepareStatement(jsql2);
	pstmt2.setString(1, ct_no);
	
	pstmt2.executeUpdate();

	if(case_no!= null)  //  (1) 주문완료로 인한 장바구니 비우기 수행하고 난 후의 주문완료 메시지 출력
	{                             //   orderOK.jsp의 107행 참조
%>
<br><br>
<center>
<font size=6 color=blue><b>[상품 주문 완료]</b></font><p>
	상품 주문이 완료되었습니다.<br><br>
	주문하신 상품은 주문 완료 후 2일 이내에 배송될 예정입니다.<br><br>
	AQUA (주)을 이용해 주셔서 감사합니다!
</center>
<%
	}
	  else   //  (2) 주문과 상관없이 장바구니 비우기를 수행한 경우의 출력
	 {response.sendRedirect("cart_show.jsp");    //   <jsp:forward page="showCart.jsp"/>와 같은 의미임
%>

<%
	  }
   } catch (Exception e) {
       out.println(e);
}
%>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>