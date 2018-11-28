<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String username = (String) session.getAttribute("username");
String date=request.getParameter("date");
String starttime=request.getParameter("stime");
String finishtime=request.getParameter("ftime");

String stime=starttime+":00";
String ftime=finishtime+":00";
int flag=0;
PreparedStatement ps,ps2;
ps=con.prepareStatement("select doctor_id from doctors where doctor_email=?");
ps.setString(1,username.trim());
ResultSet res = ps.executeQuery();
if (res.next())
{   flag=1;
	int doctor_id=res.getInt("doctor_id");
	ps2=con.prepareStatement("insert into appointment (date,start_time,end_time,doctor_id_fk) values(?,?,?,?)");
	ps2.setString(1,date.trim());
	ps2.setString(2,stime.trim());
	ps2.setString(3, ftime.trim());
	ps2.setInt(4,doctor_id);  	
	ps2.executeUpdate();
	flag=flag+1;
	%>
	echo ("<script>
		alert("Entry made");
		window.location.href='http://localhost:8080/HMS/JSP/doctorInputTime.html';
		</script>");
	<%  
}
	
if(flag!=2)
{
	%>
	echo ("<script>
		alert("Error! Please try again later.");
		window.location.href='http://localhost:8080/HMS/JSP/doctorInputTime.html';
		</script>");
	<% 
}
con.close();
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
</body>
</html>