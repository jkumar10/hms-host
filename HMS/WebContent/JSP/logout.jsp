<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	session.removeAttribute("username");
    request.getSession(false);
    session.setAttribute("username",null);	
	if(session.getAttribute("username")==null || session.getAttribute("username")=="")
	{		
		session.invalidate();
		response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader ("Expires", 0);
    	response.sendRedirect("visitorHome.html");
	}
%>
</body>
</html>