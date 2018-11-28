<%@page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    
    DataAccessLayer ob=new DataAccessLayer();
    Connection con = ob.getConnection();
    String emailInput=request.getParameter("emailInput");
    String passwordInput=request.getParameter("passwordInput");
    String firstNameInput=request.getParameter("firstNameInput");
    String lastNameInput=request.getParameter("lastNameInput");
    String addressInput=request.getParameter("addressInput");
    String specialisationInput=request.getParameter("specialisationInput");
    String accountTypeInput=request.getParameter("accountTypeInput");
    String companyNameInput=request.getParameter("companyNameInput");
    String petTypeInput=request.getParameter("petInput");
    //String ageInput=request.getParameter("ageInput");
    System.out.println(emailInput);
    System.out.println(passwordInput);
    System.out.println(firstNameInput);
    System.out.println(lastNameInput);
    System.out.println(addressInput);
    System.out.println(accountTypeInput);
    System.out.println(petTypeInput);
    
   
    int i=0;
    if (accountTypeInput.trim().equals("Doctor"))
    {   
	    try 
	    {
	    	PreparedStatement ps;
	    	ps=con.prepareStatement("Select * from doctors where doctor_email=?");
	    	ps.setString(1,emailInput.trim());
	    	ResultSet res=ps.executeQuery();
		    	if (res.next())
		    	{%>
		    		<script>alert("Username already exists");</script>
		    	<%}
		    	else
		    	{
					ps=con.prepareStatement("insert into doctors (doctor_email,doctor_password,doctor_first_name,doctor_last_name,doctor_address,doctor_specialisation) values(?,?,?,?,?,?)");
			        ps.setString(1,emailInput.trim());
			        ps.setString(2,passwordInput.trim());
			        ps.setString(3,firstNameInput.trim());
			        ps.setString(4,lastNameInput.trim());
			        ps.setString(5,addressInput.trim());
			        ps.setString(6,specialisationInput.trim());
			            //if (s2.compareTo(s3)==0)
			         i=ps.executeUpdate();
			    }
	       }
	    catch (SQLException e) 
	    {
			e.printStackTrace();
		}
	    if(i>0)
	    {%>
	    			echo ("<script>
	    	    	window.alert('Registration done. Login to continue.');
	    	        window.location.href='http://localhost:8080/HMS/JSP/loginForm.html';
	    	        </script>")
	    <%}
	    else
	     { %>
	        echo ("<script>
	    	window.alert('Error in registration, Username already exists or Password mismatch. Please try again');
	        window.location.href='http://localhost:8080/HMS/JSP/registrationForm.html';
	    </script>");
	    <%  
	     } 
    }
    
    if (accountTypeInput.equals("Patient"))
    {
    	System.out.println("Going inside Patient if condition");
    	try 
	    {
	    	PreparedStatement ps;
	    	ps=con.prepareStatement("Select * from patients where patient_email=?");
	    	ps.setString(1,emailInput.trim());
	    	ResultSet res=ps.executeQuery();
		    	if (res.next())
		    	{%>
		    		<script>alert("Username already exists");</script>
		    	<%}
		    	else
		    	{
					ps=con.prepareStatement("insert into patients (patient_email,patient_password,patient_firstname,patient_lastname,patient_address,patient_pet_type) values(?,?,?,?,?,?)");
			        ps.setString(1,emailInput.trim());
			        ps.setString(2,passwordInput.trim());
			        ps.setString(3,firstNameInput.trim());
			        ps.setString(4,lastNameInput.trim());
			        ps.setString(5,addressInput.trim());
			        ps.setString(6,petTypeInput.trim());
			        //ps.setInt(7,Integer.valueOf(ageInput));
			            //if (s2.compareTo(s3)==0)
			         i=ps.executeUpdate();
			    }
	       }
	    catch (SQLException e) 
	    {
			e.printStackTrace();
		}
	    if(i>0)
	    {%>
	    			echo ("<script>
	    	    	window.alert('Registration done. Login to continue.');
	    	        window.location.href='http://localhost:8080/HMS/JSP/loginForm.html';
	    	        </script>")
	    <%}
	    else
	     { %>
	        echo ("<script>
	    	window.alert('Error in registration, Username already exists or Password mismatch. Please try again');
	        window.location.href='http://localhost:8080/HMS/JSP/registrationForm.html';
	    </script>");
	    <%  
	     } 
    }
    if (accountTypeInput.equals("Insurance Provider"))
    {
    	System.out.println("Going inside Insurance Provider if condition");
    	try 
	    {
	    	PreparedStatement ps;
	    	ps=con.prepareStatement("Select * from insurance_providers where provider_id=?");
	    	ps.setString(1,emailInput.trim());
	    	ResultSet res=ps.executeQuery();
		    	if (res.next())
		    	{%>
		    		<script>alert("Username already exists");</script>
		    	<%}
		    	else
		    	{
					ps=con.prepareStatement("insert into insurance_providers (provider_email,provider_password,provider_address,provider_name) values(?,?,?,?)");
			        ps.setString(1,emailInput.trim());
			        ps.setString(2,passwordInput.trim());
			        ps.setString(3,addressInput.trim());
			        ps.setString(4,companyNameInput.trim());
			        
			            //if (s2.compareTo(s3)==0)
			         i=ps.executeUpdate();
			    }
	       }
	    catch (SQLException e) 
	    {
			e.printStackTrace();
		}
	    if(i>0)
	    {%>
	    			echo ("<script>
	    	    	window.alert('Registration done. Login to continue.');
	    	        window.location.href='http://localhost:8080/HMS/JSP/loginForm.html';
	    	        </script>")
	    <%}
	    else
	     { %>
	        echo ("<script>
	    	window.alert('Error in registration, Username already exists or Password mismatch. Please try again');
	        window.location.href='http://localhost:8080/HMS/JSP/registrationForm.html';
	    </script>");
	    <%  
	     } 
    }   
    con.close();
     
    %>


</body>
</html>