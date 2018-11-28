<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();

String doctorusername=(String) session.getAttribute("username");
String date=request.getParameter("date");
int doctorID=0;
PreparedStatement ps,ps2;
ps=con.prepareStatement("select doctor_id from doctors where doctor_email=?");
ps.setString(1, doctorusername.trim());
ResultSet res=ps.executeQuery();
if (res.next()==true)
{
	doctorID=res.getInt(1);
}

ps2=con.prepareStatement("select start_time,pid from book where doctor_id=? and date=?");
ps2.setInt(1, doctorID);
ps2.setString(2,date);
ResultSet res2=ps2.executeQuery();
int flag=0;
while (res2.next())
{

//out.println("<div class=\'radio-group\'>");
if (flag==0)
{
out.println("<table id='tables'>");
out.println("<th>Date</th>");
out.println("<th>Start Time</th>");
out.println("<th>Patient ID</th>");
}
flag=flag+1;
res.previous();

	out.println("<tr>");
    out.println("<td class='non-selectable'>"+date+"</td>");
    out.println("<td class='non-selectable'>"+res2.getString(1)+"</td>");
    out.println("<td class='non-selectable'>"+res2.getString(2)+"</td>");
    out.println("</tr>");
           
}
out.println("</tbody>");
out.println("</table>");
//out.println("</div>");

if(flag==0)
{
	out.println("<p id=customers><font size=3 color =red>You don't have any appointments on the selected date.</font></p>");
}
con.close();
}
catch (Exception e)
{
	e.printStackTrace();
}
%>