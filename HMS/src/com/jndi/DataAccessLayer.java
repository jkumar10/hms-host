package com.jndi;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DataAccessLayer {

	private Context ctx = null;
	private Connection con = null;
	private DataSource ds = null;
	public Connection getConnection() {
		
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/mysql_connector");
			con = ds.getConnection();
			return con;
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return null;
		}

	}
	
	public void closeConnection(Connection con) throws SQLException {
		con.close();
	}
}
