<%@ page import="com.justice.HttpHelper,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true" %><%!
    //Returns a query to match the account type
    boolean checkNormalUserExists(String accountType, String email, String password) {
        String queryStr = null;
        switch(accountType) {
            case "Patient":
                queryStr = "Select patient_password from patients where patient_email=? AND patient_password=?";
                break;
            case "Doctor":
                queryStr = "Select doctor_password from doctors where doctor_email=? AND doctor_password=?";
                break;
            case "Insurance Provider":
                queryStr = "Select provider_password from insurance_providers where provider_email=? AND provider_password=?";
                break;
            default:
                return false;
        }
        
        Connection con = null;
        try {
            DataAccessLayer ob=new DataAccessLayer();
            con = ob.getConnection();
            PreparedStatement ps = con.prepareStatement(queryStr);
            ps.setString(1, email);
            ps.setString(2, password);

            return ps.executeQuery().next(); //If a single row exists then it must exist
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
	    if(con != null) {
                try {
		    con.close();
		} catch(SQLException e) {
		    e.printStackTrace();
		}
	    }
        }
        return false;
    }

    /*boolean checkEmailAndOAuthExists(String accountType, String email) {
        //TODO:CHECK IF USER WAS SIGNED UP WITH OAUTH
        String queryStr = null;
        switch(accountType) {
            case "Patient":
                queryStr = "Select patient_email from patients where patient_email=?";
                break;
            case "Doctor":
                queryStr = "Select doctor_email from doctors where doctor_email=?";
                break;
            case "Insurance Provider":
                queryStr = "Select provider_email from insurance_providers where provider_email=?";
                break;
            default:
                return false;
        }
        
        Connection con = null;
        try {
            DataAccessLayer ob=new DataAccessLayer();
            con = ob.getConnection();
            PreparedStatement ps = con.prepareStatement(queryStr);
            ps.setString(1, email);
            ps.setString(2, googleOAuthUsed);

            return ps.executeQuery().next(); //If a single row exists then it must exist
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
	    if(con != null) {
                try {
		    con.close();
		} catch(SQLException e) {
		    e.printStackTrace();
		}
	    }
        }
        return false;
    }*/

	//Returns true if a user exists for the given account-type
	boolean checkOAuthUserExists(String accountType, String email) {
		//TODO: Add checking to ensure user is an oauth account
	
		DataAccessLayer ob = new DataAccessLayer();
		Connection con = null;
		try {
			con = ob.getConnection();
			PreparedStatement ps = null;
			
			if(accountType.equals("Patient")) {
				ps=con.prepareStatement("Select * from patients where patient_email=?");
			}
			else if(accountType.equals("Doctor")) {
				ps=con.prepareStatement("Select * from doctors where doctor_email=?");
			}
			else if(accountType.equals("Insurance Provider")) {
				ps=con.prepareStatement("Select * from insurance_providers where provider_email=?");
			}
			ps.setString(1, email);
			ResultSet res = ps.executeQuery();
			

			return res.next(); //If anyone is found then it's a success
		} catch(Exception e) {
			e.printStackTrace();	
		} finally {
			if(con != null) {
				try {
					con.close();
				} catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}


    //Broken out email sub-routine
    //returns either the otp string or null
    String sendEmailFunc(String emailInput) {
        try {
    	    SendEmail email = new SendEmail(); //send email	
            email.sendEmail(1, emailInput);

	    return email.getOtp(); //Add failed to send email checking??, return false if failed
	} catch(Exception e) { //TODO: Find specific exception type for messages - hint if you remove this catch it'll print as an error
	    e.printStackTrace();
	}
	return null; //if exception occuredd
    }

    JSONObject getRespFromIdToken(String idToken) {
	//Open a connection to the token endpoint, and post the id_token
 	String tokenInfoEndpoint = "https://www.googleapis.com/oauth2/v3/tokeninfo";
	String urlParameters = "id_token=" + idToken;
	String resp = HttpHelper.executePost(tokenInfoEndpoint, urlParameters);

	JSONParser jsonParser = new JSONParser();
	try {
		JSONObject respObj = (JSONObject)jsonParser.parse(resp);
		return respObj;
	} catch(Exception e) {
		e.printStackTrace();
	}
	return null;
    }
%><%
    boolean userLogIn = false;
    String email = null;

    String emailInput=request.getParameter("emailInput");
    if(emailInput != null) {
    	emailInput = emailInput.trim();
    }
    String passwordInput=request.getParameter("passwordInput");
    if(passwordInput != null) {
    	passwordInput = passwordInput.trim();
    }
    String accountTypeInput=request.getParameter("accountTypeInput").trim();

    String idTokenInput = request.getParameter("idToken");

    if(idTokenInput != null) {
        try {
	    //Get email from id_token
      	    JSONObject respObj = getRespFromIdToken(idTokenInput);
	    email = (String)respObj.get("email");
	    //Check that user exists
	    userLogIn = checkOAuthUserExists(accountTypeInput, email);
        } catch(Exception e) {
	    e.printStackTrace();
	}
	//userLogIn = oAuthLoginUser(accountTypeInput, idTokenInput);
    }
    else {
   	email = emailInput;
	userLogIn = checkNormalUserExists(accountTypeInput, email, passwordInput);
    }

    //If user is able to login then do so then send otp email
    if(userLogIn) {
    	String otp = sendEmailFunc(email);
        if(otp != null) {
	    System.out.println("Sign in as 1: " + email);
            session.setAttribute("username", email);
            session.setAttribute("accountTypeInput", accountTypeInput);
            session.setAttribute("otpValue", otp);
	    System.out.println("Signed in as 2:" + ((String)session.getAttribute("username")));
	    out.println("1");
       }
       else {
       		out.println("2");
       }
    }
    else {
	    out.println("0"); 
    }
    
    // This file prints out a boolean string of rather or not login was successful
    // 1 mean succeess
    // 0 means user doesnt exist
    // 2 means email based error
%>
