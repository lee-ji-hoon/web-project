<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../../layout/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../../css/table_style_ver2.css">
<center>
<%
	request.setCharacterEncoding("utf-8");

	String  id = request.getParameter("id");   
	String  password = request.getParameter("password");
	String  name = request.getParameter("name");

	String	joomin1 = request.getParameter("joomin1");
	String	joomin2 = request.getParameter("joomin2");
	String  joomin = joomin1 + "-" + joomin2;

	String  birth = request.getParameter("date");

	String	solar = request.getParameter("solar");
	
	String	phone1 = request.getParameter("phone1");
	String	phone2 = request.getParameter("phone2");
	String	phone3 = request.getParameter("phone3");
	String  phone = phone1 + "-" + phone2 + "-" + phone3;
	
	String	email = request.getParameter("email");
	String	address = request.getParameter("address");

	String	sex = request.getParameter("sex");
			

try {
 	String DB_URL="jdbc:mysql://localhost:3306/aqua_project";   //  DB명이 project임
    String DB_ID="aqua"; 
    String DB_PASSWORD="1234";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver"); 
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	 String jsql = "INSERT INTO member (m_id, m_password, m_name, m_date, m_gender, m_email, m_phone, m_joomin, m_address, m_solar) values(?,?,?,?,?,?,?,?,?,?)";

	 PreparedStatement pstmt  = con.prepareStatement(jsql);
	 pstmt.setString(1,id);
	 pstmt.setString(2,password);
	 pstmt.setString(3,name);
	 pstmt.setString(4,birth);
	 pstmt.setString(5,sex);
	 pstmt.setString(6,email);
	 pstmt.setString(7,phone);
	 pstmt.setString(8,joomin);
	 pstmt.setString(9,address);
	 pstmt.setString(10,solar);
	 
	 pstmt.executeUpdate();
	 
	 
  } catch(Exception e) { 
		out.println(e);
}
%>
<div align=center>
	<table style="font-size:10pt;font-family:맑은 고딕">
	<tr>
		<th colspan="2" class="table_title">회원 가입 완료</th>
	</tr>
	<tr>
		<th width=100>ID</th>
		<td width=200><%=id%></td>
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
		<th>주민등록번호</th>
		<td><%=joomin%></td>
	</tr>
	<tr>
		<th>생년월일</th>
		<td>
			<%=birth%>
			(<%=solar%>)
		</td>
	</tr>
	<tr>
		<th>휴대폰번호</th>
		<td><%=phone%></td>
	</tr>
	<tr>
		<th>성별</th>
		<td><%=sex%></td>
	</tr>
	<tr>
		<th>주소</th>
		<td><%=address %></td>
	</tr>
	</table>
	<p>
<br>
 <a href="../login/login.jsp" style="font-size:10pt;font-family:맑은 고딕" >로그인</a>
 </div>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>