package com.jndi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class JndiTest
 */
@WebServlet("/JndiTest")
public class JndiTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public JndiTest() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("here in get");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		DataAccessLayer ob=new DataAccessLayer();
	    Connection con = ob.getConnection();
	    try {
			PreparedStatement ps=con.prepareStatement("insert into doctors (doctor_id,doctor_email,doctor_password,doctor_first_name,doctor_last_name,doctor_address,doctor_specialisation) values(?,?,?,?,?,?,?)");
			ps.setInt(1,3);
            ps.setString(2,"xyz@gmail.com");
            ps.setString(3,"xyz");
            ps.setString(4,"xyz");
            ps.setString(5,"xyz");
            ps.setString(6,"xyz");
            ps.setString(7,"xyz");
            ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
