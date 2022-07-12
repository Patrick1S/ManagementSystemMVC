package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Conn {
	private	Connection con=null;

	private void connect(){
		try {
			//2.连接数据库
			//39.107.79.42

			con = DriverManager
					.getConnection("jdbc:mysql://39.105.220.225:3306/javaweb?serverTimezone=UTC&characterEncoding=utf8&user=root&password=115225");
			System.out.println("连接成功!");
		}catch (SQLException e1) {
			System.out.println("连接失败");
			e1.printStackTrace();
		}
	}

	public Connection getCon(){
		this.connect();
		return con;
	}

	public void close() throws SQLException {
		con.close();
	}

}
