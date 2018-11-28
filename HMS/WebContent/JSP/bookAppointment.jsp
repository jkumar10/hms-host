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
String doctorID=request.getParameter("doctor_id");
String formdate=request.getParameter("date");
String formtime=request.getParameter("time");
String Username=(String)session.getAttribute("username");

int flag=0;
String formtime2="";
if (Integer.parseInt(formtime)<10)
{	
	formtime2="0"+formtime+":00:00";
	System.out.println(formtime);
	flag=1;
}
if (Integer.parseInt(formtime)>=10)
{	
	formtime2=formtime+":00:00";
	System.out.println(formtime);
	flag=1;
}
System.out.println(flag);
if (flag==1)
{
PreparedStatement ps;

  			if(doctorID!=null && formdate!=null && formtime!=null && Username!=null)
    		{
    			ps=con.prepareStatement("insert into book (doctor_id,start_time,date,pid) values(?,?,?,?)");
	        	ps.setString(1,doctorID.trim());
	        	ps.setString(2,formtime2.trim());
	        	ps.setString(3, formdate.trim());
	        	ps.setString(4, Username.trim());  	
	        	ps.executeUpdate();
	        	%>
	        	echo ("<script>
	        		alert("Appointment made");
	        		window.location.href='http://localhost:8080/HMS/JSP/scheduleAppointment.html';
	        		</script>");
    			<%  
    			PreparedStatement psDoc = con.prepareStatement("select * from doctors where doctor_id=?");
    			psDoc.setString(1,doctorID.trim());
    			ResultSet rsDoc = psDoc.executeQuery();
    			if(rsDoc.next()) {
    				String doclname = rsDoc.getString("DOCTOR_LAST_NAME");
    				String docaddr = rsDoc.getString("DOCTOR_ADDRESS");
    				System.out.println("doclname: " + doclname);
    				System.out.println("docaddr: " + docaddr);
    				SendEmail email = new SendEmail();
        			email.sendApptConfim(Username, formtime2, formdate, doclname, docaddr);
    			}
    		}
    		
    
 
			else
			{%>
			echo ("<script>
			alert("Error in appointment. Please try again later");
			window.location.href='http://localhost:8080/HMS/JSP/scheduleAppointment.html';
			</script>");
			<%}

}  
con.close();
}
catch(Exception e)
{
	e.printStackTrace();
	%>
	echo ("<script>
	alert("Error in appointment");
	window.location.href='http://localhost:8080/HMS/JSP/scheduleAppointment.html';
	</script>");
	<%
}

%>
</body>
</html>