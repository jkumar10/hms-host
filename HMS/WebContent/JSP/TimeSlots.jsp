<%@ page import="java.sql.*,com.jndi.*, java.util.Date,java.util.ArrayList, java.text.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String doctorID=request.getParameter("doctor_id");
String formdate=request.getParameter("date");
System.out.println(doctorID);
System.out.println(formdate);
//String formtime="20:00:00";
PreparedStatement ps,ps2;
int flag=0;
ps=con.prepareStatement("SELECT TIME_FORMAT(start_time, '%H'), TIME_FORMAT(end_time, '%H') from appointment where doctor_id_fk=? and date=?");
ps.setInt(1,Integer.valueOf(doctorID));
ps.setDate(2,java.sql.Date.valueOf(formdate));
ResultSet res1=ps.executeQuery();
// IF RES1 CONTAINS ANY VALUE THEN THAT MEANS DOCTOR IS AVAILABLE ON THAT PARTICULAR DAY AND THE PATIENT CAN BOOK THE TIME SLOT IF IT IS AVAILABLE 
if(res1.next())
{   
	String temp_time;
	int time;
    String start_time=res1.getString(1);      //RETRIEVING THE START_TIME
    String end_time=res1.getString(2);        //RETRIEVING THE END_TIME
    int start_integer=Integer.valueOf(start_time);
    int end_integer=Integer.valueOf(end_time);
    
    
    
    ps2=con.prepareStatement("SELECT TIME_FORMAT(start_time, '%H') from book where doctor_id=? and date=?");
	ps2.setInt(1,Integer.valueOf(doctorID));
	ps2.setDate(2,java.sql.Date.valueOf(formdate));
	ResultSet res2=ps2.executeQuery();   //res2 contains all the booked time slots from the book table
	ArrayList<Integer> hourlist = new ArrayList<Integer>();  
	//adding all the booked timeslots in hourlist which is an arraylist
	while(res2.next())
	{   
		flag=1;
		temp_time=res2.getString(1);
		time=Integer.parseInt(temp_time);
		hourlist.add(time);
	}
	
	int flag2=0;
	
	out.println("<div id=\'TimeSlotRadioGroup\' class=\'radio-group\'>");
	
	out.println("<table id=customers>");
	//out.println("<table>");
    for(int i=start_integer;i<end_integer;i++) //running the loop from start_time to end_time with an increment of 1 hr
    {   
    flag2=0;
    flag=1;
    	
    	for (Integer hour: hourlist)
    	{
    		if(i==hour)             //if any hour between start_time and end_time is equal to the value in the arraylist then that timeslot is not available
    		{	                    // and I don't need to print that time slot. Flag2 is set to 1 and I break out of the loop.
    			flag2=1;
    			break;
    		}
    		
        
    	}
    	if (flag2==0 && i>=12)       //if flag2==0 then the time slot is not available in the array list so it is a available time slot for the user so I print it.
    	{
    		
			out.println("<tr class='radio' data-radio_value='"+i+"'>");
			out.println("<td>"+i+":00 to "+(i+1)+":00 PM</td>");
			out.println("</tr>");
    	}
    	if (flag2==0 && i<12)       //if flag2==0 then the time slot is not available in the array list so it is a available time slot for the user so I print it.
    	{
    		
			out.println("<tr class='radio' data-radio_value='"+i+"'>");
			out.println("<td>"+i+":00 to "+(i+1)+":00 AM</td>");
			out.println("</tr>");
    	}
    }	
    out.println("</tbody>");
    out.println("</table>");
    out.println("<input style='display:none;' name='time' type='text' class='radio-input'>");
    out.println("<input style='display:none;' name='date' type='text' value='" + formdate + "'>");
    out.println("<input style='display:none;' name='doctor_id' type='text' value='" + doctorID + "'>");
    out.println("</div>");
    
    if (flag==0)
    {
    	out.println("<p id=customers><font size=3 color =red>No timeslots available on selected date.</font></p>");
    }
    
    out.flush();
}	
	
	else
	{
		out.println("<p id=customers><font size=3 color =red>Doctor not available on selected date.</font></p>");
	}
con.close();

}

catch(Exception e)
{
	e.printStackTrace();
	out.println("<p id=customers><font size=3 color =red>Error in retrieving time slots. Please try agian later.</font></p>");
}
%>