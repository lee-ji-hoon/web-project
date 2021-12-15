<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../layout/header.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="../../css/style-favorite.css">
<link rel="stylesheet" href="../../css/style-index.css">
<link rel="stylesheet" href="../../css/style-common.css">


<body>

	<%
	try {
		request.setCharacterEncoding("utf-8");
		String DB_URL = "jdbc:mysql://localhost:3306/aqua_project";
		String DB_ID = "aqua";
		String DB_PASSWORD = "1234";

		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		String compList = request.getParameter("compList");
		String jsql = "select * from product where p_category = ?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, compList);

		ResultSet rs = pstmt.executeQuery();
		
		
	%>

	<div class="frame">
	<header>
		<div id="header-first">
			<form id="headerSearchForm" method="POST" action="<%=request.getContextPath()%>/member/product/goods_group_search.jsp">
				<button class="headerSearchForm-btn" onClick="keyword_check();">
					<i class="tiny material-icons">search</i>
				</button>
				<input name="keyword" placeholder="상품명으로 검색" class="headerSearchForm-input" value="" />
			</form>
	</header>
		<!-- main 타이틀 시작 -->
		<div class="favor-head border-btm-black">상품 리스트</div>
		<div id="product_order_list" style="float: right">
			<!-- 
			<a href="goods_group_popular.jsp?compList=<%=compList%>">인기순</a>
			&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp-->
			<a href="goods_group_high.jsp?compList=<%=compList%>">높은가격</a>
			&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp
			<a href="goods_group_low.jsp?compList=<%=compList%>">낮은가격</a>


		</div>
		<!-- main 타이틀 끝 -->
		<!-- sidebar 시작 -->
		<div class="favor-sidebar">
			<form name="categorys" method="post">

				<div class="favor-sidebar-title">상품 옵션</div>
				<!-- 	<div class=" custom-checkbox favor-content">
					<input type="checkbox" class="custom-control-input" id="notSoldout">
					<label class="custom-control-label" for="notSoldout">
						품절 제외
						<구현중...>
					</label>
				</div>
			 -->
				<%
				String[] compList_arr = compList.split(" ");

				String[] checked = new String[4];

				for (int i = 0; i < compList_arr.length; i++) {
					if (compList_arr[i].equals("아쿠아리움관")) {
						checked[0] = "checked";
					} else if (compList_arr[i].equals("파충류관")) {
						checked[1] = "checked";
					} else if (compList_arr[i].equals("정글존")) {
						checked[2] = "checked";
					} else if (compList_arr[i].equals("default")) {
						checked[3] = "checked";
					}
				}
				%>
				<div class=" custom-checkbox favor-content">
					<input type="radio" name="compList" value="아쿠아리움관" <%=checked[0]%> />
					아쿠아리움관
				</div>
				<div class=" custom-checkbox favor-content">
					<input type="radio" name="compList" value="파충류관" <%=checked[1]%> />
					파충류관
				</div>
				<div class=" custom-checkbox favor-content">
					<input type="radio" name="compList" value="정글존" <%=checked[2]%> />
					정글존
				</div>
				<div class=" custom-checkbox favor-content">
					<input type="radio" name="compList" value="default" <%=checked[3]%> />
					전체보기
				</div>
				<br>
				<button type="button" class="btn btn-primary" onclick="category_top()">검색</button>
			</form>
			<br>
			<div class="favor-sidebar-title">최근 본 상품</div>
			<ul class="recent">
				<%
				if (sid != null) {
					String jsql2 = "SELECT * FROM temp_recent WHERE m_id=? ORDER BY recent_date desc";
					PreparedStatement pstmt2 = con.prepareStatement(jsql2);
					pstmt2.setString(1, sid);
					ResultSet rs2 = pstmt2.executeQuery();

					while (rs2.next()) {
						String m_id = rs2.getString("m_id");
						String p_id = rs2.getString("p_id");
						String p_name = rs2.getString("p_name");
						String recent_date = rs2.getString("recent_date");
				%>
				<li>
					<a href="goods_select.jsp?p_id=<%=p_id%>">
						<li>
							<img src="../../img/product/<%=p_id%>.jpg" height="50px" width="50px">
					</a>
					&nbsp
					<a href="goods_select.jsp?p_id=<%=p_id%>"><%=p_name%></a>
					</a>
				</li>
				<%
				}
				} else {
				String ct_no = session.getId();
				String jsql2 = "SELECT * FROM temp_recent WHERE ct_no=? ORDER BY recent_date desc";
				PreparedStatement pstmt2 = con.prepareStatement(jsql2);
				pstmt2.setString(1, ct_no);
				ResultSet rs2 = pstmt2.executeQuery();

				while (rs2.next()) {
				String m_id = rs2.getString("m_id");
				String p_id = rs2.getString("p_id");
				String p_name = rs2.getString("p_name");
				String recent_date = rs2.getString("recent_date");
				%>
				<li>
					<a href="goods_select.jsp?p_id=<%=p_id%>">
						<li>
							<img src="../../img/product/<%=p_id%>.jpg" height="50px" width="50px">
					</a>
					&nbsp
					<a href="goods_select.jsp?p_id=<%=p_id%>"><%=p_name%></a>
					</a>
				</li>
				<%
				}
				}
				%>
			</ul>
		</div>
	</div>
	<!-- sidebar 끝 -->
	<!-- 좌측박스 시작 -->
	<main id="main-prd">
		<div class="favor-item-box" id="favor-item-box">

			<div class="favor-prd-list">
				<%
				while (rs.next()) {
					String p_id = rs.getString("p_id");
					String p_name = rs.getString("p_name");
					int p_price = Integer.parseInt(rs.getString("p_price"));
					int p_stock = Integer.parseInt(rs.getString("p_stock"));
					String p_category = rs.getString("p_category");
					String p_description = rs.getString("p_description");
					String p_option = rs.getString("p_option");
				%>
				<div class="favor-prd-box">
					<a class="favor-link-prod" href="goods_select.jsp?p_id=<%=p_id%>"></a>
					<img src="../../img/product/<%=p_id%>.jpg" class="main-prd-item-img" />
					<ul class="favor-prd-item">
						<!-- 상품이미지 -->
						<li class="prd-item-company"><%=p_category%></li>
						<!-- 카테코 -->
						<li class="prd-item-name"><%=p_name%></li>
						<!-- 상품명 -->
						<li class="prd-item-price">
							<fmt:formatNumber value="<%=p_price%>" type="number" />
							원
						</li>
						<!-- 가격 -->
						<%
						if (p_stock > 0) {
						%>
						<li class="prd-item-soldCount"><%=p_stock%>판매
						</li>
						<%
						} else {
						%>
						<li class="prd-item-name" style="color: red;">품절 상품입니다.</li>
						<%
						}
						%>
						<!-- 판매량 default = 0 -->
					</ul>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</main>
	<!-- 좌측박스 끝 -->

	</div>
	<!-- 전체 박스 끝 -->
	<%
} catch (Exception e) {
out.println(e);
}
%>
	<%@ include file="../../layout/footer.jsp"%>
	<script type="text/javascript" src="../../js/categories.js"></script>