<%@page import="java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*, javax.servlet.http.*" %>
<%

    /*--CODE WRITTEN BY SIDDHARTH DHARM. 
        LAST MODIFIED ON 20/06/2017.
        BITS PILANI HYDERABAD CAMPUS.--*/


    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";         // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/pcgt";   // URL of your Database //
    final String USER = "root";                                 // Database credentials //
    final String PASS = "";
    Connection conn = null;
    Statement stmt = null;

	try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    String del = "DELETE FROM rawdata1";
    String del1 = "DELETE FROM rawdata2";
    String del2 = "DELETE FROM binneddata";
    String del3 = "DELETE FROM rawsitedetails";
    String del4 = "DELETE FROM result1";
    String del5 = "DELETE FROM result2";
    String del6 = "DELETE FROM staticfrequency";
    String del7 = "DELETE FROM staticpower";
    String del8 = "DELETE FROM uncertainty";
    String del9 = "DELETE FROM inter1";
    String del10 = "DELETE FROM result3";

    stmt = conn.createStatement();
    stmt.executeUpdate(del);
    stmt.executeUpdate(del1);
    stmt.executeUpdate(del2);
    stmt.executeUpdate(del3);
    stmt.executeUpdate(del4);
    stmt.executeUpdate(del5);
    stmt.executeUpdate(del6);
    stmt.executeUpdate(del7);
    stmt.executeUpdate(del8);
    stmt.executeUpdate(del9);
    stmt.executeUpdate(del10);
    stmt.close();

    conn.close();

    String site = new String("/Mytrah/PCGT/index.html");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    
    }catch(SQLException se){
    //Handle errors for JDBC
    se.printStackTrace();
    }catch(Exception e){
    //Handle errors for Class.forName
    e.printStackTrace();
    }finally{
    //finally block used to close resources
    try{
    if(stmt!=null)
    stmt.close();
    }catch(SQLException se2){
    }// nothing we can do
    try{
    if(conn!=null)
    conn.close();
    }catch(SQLException se){
    se.printStackTrace();
    }//end finally try
    }//end try
      
    %>
    </html>