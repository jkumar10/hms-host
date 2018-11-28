package com.jndi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mysql.*;
import java.sql.*;

/**
 * Servlet implementation class Test_Connection
 */
@WebServlet("/Test_Connection")
public class Test_Connection extends HttpServlet 
{
	
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try
		{
		String DB_URL= "jdbc:mysql://ec2-35-174-225-107.compute-1.amazonaws.com:3306/hmsDB";
	    String USER="hms2";
	    String PASSWRD="vetpetsys";
	    System.out.println("----MySQL JDBC Connection Testing -------");
	    try
	    {
		Class.forName("com.mysql.jdbc.Driver");
	    }
	    catch(ClassNotFoundException e)
	    {
	    	System.out.println(e.getMessage());
	    }
	   
	    Connection conn = DriverManager.getConnection(DB_URL,USER,PASSWRD);
		}
	    catch (SQLException e) 
	    {
	        System.out.println("Connection Failed!:\n" + e.getMessage());
	    }

	    
	}
}
