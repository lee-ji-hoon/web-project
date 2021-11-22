<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../layout/header_manager.jsp" %>
<link rel="stylesheet" href="../../css/tickets_style.css?abc">
	<div align="center">
		<font color="blue" size='6'><b>[전체 티켓 조회]</b></font>
		<p>
		<table id = 'manager_t_sel_table' border="1" width=1000 style="font-size: 10pt; font-family: 맑은 고딕; table-layout:fixed">
			<tr>
				<td id = 'manager_t_sel_title'>티켓 ID</td>
				<td id = 'manager_t_sel_title'>티켓 등록일</td>
				<td id = 'manager_t_sel_title'>관람 장소</td>
				<td id = 'manager_t_sel_title'>티켓 이름</td>
				<td id = 'manager_t_sel_title'>티켓 가격(어른)</td>
				<td id = 'manager_t_sel_title'>티켓 가격(청소년)</td>
				<td id = 'manager_t_sel_title'>티켓 가격(어린이)</td>
				<td id = 'manager_t_sel_title'>티켓 설명</td>
				<td id = 'manager_t_sel_title'>
					<b><font color=blue>[삭제]</font></b>
				</td>
			</tr>

			<%
			try {
				String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
				String DB_ID = "aqua";
				String DB_PASSWORD = "1234";

				Class.forName("org.gjt.mm.mysql.Driver");
				Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

				String jsql = "SELECT * FROM ticket";
				PreparedStatement pstmt = con.prepareStatement(jsql);
				ResultSet rs = pstmt.executeQuery();

				while (rs.next()) {
					String t_id = rs.getString("t_id");
					Date t_in_date = rs.getDate("t_in_date");
					String t_place = rs.getString("t_place");
					String t_name = rs.getString("t_name");
					int t_price_adult = rs.getInt("t_price_adult");
					int t_price_teen = rs.getInt("t_price_teen");
					int t_price_child = rs.getInt("t_price_child");
					String t_description = rs.getString("t_description");
			%>
			<tr>
				<td align="center">
					<%=t_id%>
				</td>
				<td align="center">
					<%=t_in_date%>
				</td>
				<td align="center">
					<%=t_place%>
				</td>
				<td align="center">
					<%=t_name%>
				</td>
				<td align="center" style="text-overflow:ellipsis; overflow:hidden">
					<%=t_price_adult%> 원
				</td>
				<td align="center" style="text-overflow:ellipsis; overflow:hidden">
					<%=t_price_teen%> 원
				</td>
				<td align="center" style="text-overflow:ellipsis; overflow:hidden">
					<%=t_price_child%> 원
				</td>
				<td align="center" width=300 height=20 style="text-overflow:ellipsis; overflow:hidden">
					<%=t_description%>
				</td>
				<td>
					<a href="manager_tickets_delete.jsp?t_id=<%=t_id%>">
						<div align="center">Yes</div>
					</a>
				</td>
			</tr>
			<%
	 }
%>
		</table>
		<p>
			<br>
			<a href="manager_tickets_insert.jsp" align=center style="font-size: 10pt; font-family: 맑은 고딕">신규 티켓 등록</a>
			<br> <br>

			<%
    } catch (Exception e) {
      out.println(e);	
}
%>
		
	</div>
</body>
</html>