<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.image.BufferedImage"%>


<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String specialisation=request.getParameter("specialisation");

PreparedStatement ps;

	
ps=con.prepareStatement("select doctor_first_name, doctor_last_name, doctor_address, doctor_specialisation, doctor_id, doctor_rating, doctor_description, doctor_qualification, doctor_rating, count from doctors where doctor_specialisation=?");
ps.setString(1, specialisation.trim());
ResultSet res=ps.executeQuery();
String imgLen="";
if (res.next()==true)
{
out.println("<div class=\'radio-group\'>");
out.println("<table id=customers>");

out.println("<th></th>");
out.println("<th><img src='../pics/docicon.png' alt='' width='50' height='50'>&nbsp;Name</th>");
out.println("<th><img src='../pics/addressicon.png' alt='' width='50' height='50'>&nbsp;Address</th>");
out.println("<th><img src='../pics/specicon.png' alt='' width='50' height='50'>&nbsp;Specialisation</th>");
out.println("<th><img src='../pics/ratingicon.png' alt='' width='50' height='50'>&nbsp;Rating</th>");
res.previous();

while(res.next())
{ 
	int rating=res.getInt(9);
	int count=res.getInt(10);
	int averagerating= count >0 ? rating/count : 0;
	
    out.println("<tr class='radio' data-radio_value='" + res.getString(5) + "'>");
   
    if (res.getString(1).equals("Fiona"))
    		{
    			out.println("<td class='non-selectable'><img src='../docpics/Fiona.jpg' alt='' width='170' height='170'></td>");
    		}
    else if (res.getString(1).equals("Nicholas"))
	{
		out.println("<td class='non-selectable'><img src='../docpics/Nicholas.jpg' alt='' width='170' height='170'></td>");
	}
    else if (res.getString(1).equals("Tracey"))
	{
		out.println("<td class='non-selectable'><img src='../docpics/Tracey.jpg' alt='' width='170' height='170'></td>");
	}
    else if (res.getString(1).equals("Michelle"))
	{
		out.println("<td class='non-selectable'><img src='../docpics/Michelle.jpg' alt='' width='170' height='170'></td>");
	}
    else if (res.getString(1).equals("Aaron"))
	{
		out.println("<td class='non-selectable'><img src='../docpics/Aaron.jpg' alt='' width='170' height='170'></td>");
	}
    else if (res.getString(1).equals("Roger"))
	{
		out.println("<td class='non-selectable'><img src='../docpics/Roger.jpg' alt='' width='170' height='170'></td>");
	}
    else if (res.getString(1).equals("Bruce"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Bruce.png' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Carlo"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Carlo.png' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Christian"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Christian.png' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Jack"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Jack.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Jim"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Jim.png' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Maggie"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Maggie.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Meghan"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Meghan.png' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Nick"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Nick.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Philip"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Philip.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Randolph"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Randolph.png' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Shianne"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Shianne.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Andrew"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Andrew.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Brian"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Brian.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Kristen"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Kristen.jpg' alt='' width='170' height='170'></td>");
   	}
    else if (res.getString(1).equals("Adam"))
   	{
   		out.println("<td class='non-selectable'><img src='../docpics/Adam.jpg' alt='' width='170' height='170'></td>");
   	}
    else
    {
    	out.println("<td class='non-selectable'><img src='../docpics/doctor.png' alt='' width='170' height='170'></td>");
    }
	out.println("<td class='non-selectable'>"+"<b>Dr. "+res.getString(1)+" "+res.getString(2)+"</b><br><p style=font-size:14px;color:blue>"+res.getString(7)+"</p><br><p style=font-size:14px;color:blue>"+res.getString(8)+"</p></td>");
    out.println("<td class='non-selectable'>"+res.getString(3)+"</td>");
    out.println("<td class='non-selectable'>"+res.getString(4)+"</td>");
    out.println("<td>");
    if(averagerating==5)
    {	for(int i=1;i<=5;i++)
			out.print("<img src='../Ratings/star-on.png' height='20' width='20'>");
	}
    if(averagerating<5 && averagerating>=4)
    {	for(int i=1;i<=4;i++)
			out.print("<img src='../Ratings/star-on.png' height='20' width='20'>");
    	out.print("<img src='../Ratings/star-off.png' height='20' width='20'>");
	}
    if(averagerating<4 && averagerating>=3)
    {	for(int i=1;i<=3;i++)
    		out.print("<img src='../Ratings/star-on.png' height='20' width='20'>");
    	out.print("<img src='../Ratings/star-off.png' height='20' width='20'>");
    	out.print("<img src='../Ratings/star-off.png' height='20' width='20'>");
    }
    if(averagerating<3 && averagerating>=2)
    {	for(int i=1;i<=2;i++)
			out.print("<img src='../Ratings/star-on.png' height='20' width='20'>");
        for(int j=1;j<=3;j++)
        	out.print("<img src='../Ratings/star-off.png' height='20' width='20'>");
	}
    if(averagerating<=1)
    {
    	out.print("<img src='../Ratings/star-on.png' height='20' width='20'>");
    	for(int k=1;k<=4;k++)
        	out.print("<img src='../Ratings/star-off.png' height='20' width='20'>");
    }
    out.println("</td>");
    out.println("</tr>");
           
}
out.println("</tbody>");
out.println("</table>");

out.println("<input style='display:none' name='doctor_id' type='text' class='radio-input'>");
out.println("</div>");
}
else
{
	out.println("<p id=customers><font size=3 color =red>No doctors exist with selected speciality.</font></p>");
}
con.close();
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
<div id="customers">
<br><br><br>
<h4>Select Date:</h4><br>
<input type="date" name="date"><br><br>

<input type="submit" value="Check Available Time Slots" class="button">
</div> 
