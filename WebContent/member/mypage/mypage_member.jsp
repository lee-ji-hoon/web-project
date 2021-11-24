<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
<%@ include file="../../layout/mypage_header.jsp"%>
<link rel="stylesheet" type="text/css" href="../../css/style-table.css?v=123">
<!--  menu list 시작  -->
    <section id="menu">
		 <ul class="hbox-menu">
		    <li><a href="${pageContext.request.contextPath}/member/mypage/mypage_member.jsp" style="color:black">회원정보</a></li>
		    <li><a href="${pageContext.request.contextPath}/member/mypage/mypage_order.jsp">구매내역</a></li>
		    <li><a href="${pageContext.request.contextPath}/member/mypage/mypage_qna.jsp">문의내역</a></li>
		    <li><a href="${pageContext.request.contextPath}/member/mypage/mypage_cart.jsp">장바구니</a></li>
		    <li><a href="${pageContext.request.contextPath}/member/mypage/mypage_dibs.jsp">찜목록</a></li>
	    </ul>
	</section>
	
<%
try {
	String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
	String DB_ID = "aqua";
	String DB_PASSWORD = "1234";

	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	String jsql = "select * from member where m_id = ?";
	PreparedStatement pstmt = con.prepareStatement(jsql);
	pstmt.setString(1, sid);

	ResultSet rs = pstmt.executeQuery(); //SQL문 실행	
	rs.next();

	String id = rs.getString("m_id");
	String password = rs.getString("m_password");
	String name = rs.getString("m_name");
	String birth = rs.getString("m_date");
	String sex = rs.getString("m_gender");
	String email = rs.getString("m_email");
	String phone = rs.getString("m_phone");
	String joomin = rs.getString("m_joomin");
	String address = rs.getString("m_address");
	String solar = rs.getString("m_solar");
%>

	
	<center>
	<font  size='6'>
		<b>[<%=sid %>님의 상세 정보] </b>
	</font>
	<p>
		<table border="2" cellpadding="10"
		style="font-size: 10pt; font-family: 맑은 고딕" class="detail">
		<tr>
			<th>ID</th>
			<td><%=id%></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><%=password%></td>
		</tr>
		<tr>
			<th>성명</th>
			<td><%=name%></td>
		</tr>
		<tr>
			<th>주민번호</th>
			<td><%=joomin%></td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td><%=birth%>
				(<%=solar%>)</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%=phone%></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><%=address%></td>
		</tr>
		<tr>
			<th>휴대폰번호</th>
			<td><%=phone%></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=email%></td>
		</tr>
		<tr>
			<th>성별</th>
			<td><%=sex%></td>
		</tr>
    </table>
	<p>

<a href="mypage_member_update.jsp?id=<%=id%>"
			style="font-size:10pt;font-family:맑은 고딕">수정</a>&nbsp;&nbsp;

</center>
    
<%
} catch (Exception e) {
out.println(e);
}
%>
</body>
<%@ include file="../../layout/footer.jsp"%>
</html>