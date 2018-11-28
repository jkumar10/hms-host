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
String rating=request.getParameter("rating");
float rate=Float.parseFloat(rating);
String doctor_id=request.getParameter("doctor_id");
int doctorID=Integer.parseInt(doctor_id);
String feedback=request.getParameter("textFeedback");
PreparedStatement ps,ps2;
float r,averagerating;
int count;
float total=0;
averagerating=0;
count=0;
int flag=0;
ps=con.prepareStatement("select doctor_rating,count from doctors where doctor_id=?");
ps.setInt(1, doctorID);
ResultSet res=ps.executeQuery();
if (res.next()==true)
{   flag=1;
	r=res.getInt(1);
	count=res.getInt(2);
	total=r+rate;
	int newcount=count+1;
	ps2=con.prepareStatement("update doctors set doctor_rating=?, count=? where doctor_id=?");
    ps2.setFloat(1,total);
    ps2.setInt(2,newcount);
    ps2.setInt(3,doctorID);
	int res2=ps2.executeUpdate();
	if(count==0)
	{
		averagerating=rate;
	}
	else
	{
	averagerating=total/newcount;
	}
	
 }%>

echo ("<script>
alert("Rating submitted.");
window.location.href='http://localhost:8080/HMS/JSP/scheduleAppointment.html';
</script>");
 <%
//out.println(flag);
con.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>
</html>