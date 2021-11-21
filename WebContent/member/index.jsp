<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../layout/header.jsp"%>
<jsp:include page="../layout/popup.jsp"/>



<c:choose>
	<c:when test="${empty sid}">
		<title>aqua</title>
	</c:when>
	<c:otherwise>
		<title><%=sid %>님 환영합니다</title>
	</c:otherwise>
</c:choose>
</head>

<body>

</body>