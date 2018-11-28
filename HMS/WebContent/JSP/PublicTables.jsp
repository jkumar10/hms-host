<%@ page import="java.sql.*,com.jndi.*,java.lang.StringBuilder" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%!
	//Takes a sql querty and an array of column names
	//The number of selected elements should be equal or less than the number of column names
	//The query will be executed and converted into json with column names used as the keys
	String tableToJson(String query, String[] columns) {
		StringBuilder json = new StringBuilder();
		Connection conn = null;
		try {
			DataAccessLayer ob = new DataAccessLayer();
			conn = ob.getConnection();

			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet res = ps.executeQuery();

			if(res.next()) {
				json.append("[");
				while(res.next()) {
					json.append("{");
					for(int i = 0; i < columns.length; i++) {
    						json.append("\"");
						json.append(columns[i]);
						json.append("\": \"");
						json.append(res.getString(i+1));
						json.append("\"");
						if(i != columns.length-1) {
							json.append(", ");
						}
					}
					json.append("}");
					if(!res.isLast()) {
						json.append(", ");
					}
				}
				json.append("]");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
    			try {
 				if(conn != null) {
    					conn.close();
    				}
    			} catch(Exception e) {
    				e.printStackTrace();
    			}
		}

    		return json.toString();
	}
%>
<%
	String table = request.getParameter("table");
	String json = "";
	String query = null;
	String[] columns = null;

	if(table.equals("doctors")) {
		columns = new String[] {
			"doctor_first_name",
			"doctor_last_name",
			"doctor_address",
			"doctor_specialisation",
			"doctor_id"	
		};
		query = "SELECT " + String.join(", ", columns) + " FROM doctors";
	}
	else if(table.equals("insurance_plans")) {
		columns = new String[] {
			"plan_id",
			"plan_name",
			"provider_id",
			"provider_name",
			"plan_premium",
			"plan_coverage",
			"plan_deduction",
			"pet_type"
		};
		query = "SELECT " + String.join(", ", columns) + " FROM insurance_plans";
	}
	json = tableToJson(query, columns);
	out.println(json);
%>
