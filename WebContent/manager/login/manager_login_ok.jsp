<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<html>
<head>
<title>�α��� ���</title>
</head>

<body>


<%
	
 	String DB_URL="jdbc:mysql://localhost:3306/aqua_project";   //  DB���� project��
    String DB_ID="aqua"; 
    String DB_PASSWORD="1234";
 	 
	Class.forName("org.gjt.mm.mysql.Driver");  
 	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    String jsql = "select * from manager where manager_id = ? ";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery(); 

    if( rs.next() )
    {
          if (pass.equals(rs.getString("manager_password")))
          {
              session.setAttribute("manager_id", id);
              response.sendRedirect("../manager_index.jsp"); 

		   }  else {  
%>
           <br><br><br>
	       <font color=blue size=6><������ �α��� ����!></font><p><br><br>
           <font color=black size=3>
                ��й�ȣ�� �߸� �Ǿ����ϴ�.  �ٽ� Ȯ���� �ּ���!<p>
		        �α��� �������� ���ư��÷��� 
		 	    <a href="manager_login.jsp">����</a>�� Ŭ���Ͻð�, <p>
		 	    ���� �������� ���ư��÷���
			    <a href="index.html">����</a>�� Ŭ���ϼ���!
		   </font>              
<%       
          }     
    } else {  
 %>
       <br><br><br>
      <font color=blue size=6><������ �α��� ����!></font><p><br><br>
	  <font color=black size=3>
			���̵� �������� �ʽ��ϴ�.	 �ٽ� Ȯ���� �ּ���!<p>
			�α��� �������� ���ư��÷��� 
			<a href="manager_login.jsp">����</a>�� Ŭ���Ͻð�, <p>
			���� �������� ���ư��÷���
			<a href="index.html">����</a>�� Ŭ���ϼ���!
	   </font>

<%
   } 
%>
</body>
</html>