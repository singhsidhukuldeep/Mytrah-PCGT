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

    String result3location = "";

	String str = "SELECT result3 FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        result3location = rs.getString("result3");
    }
    stmt.close();

    // EXPORTING TABLE ONTO SERVER FROM MySQL

    String delete3 = "cmd /c "+result3location.substring(0,2)+" & cd "+result3location+" & del /Q result3.csv";
    Process process3 = Runtime.getRuntime().exec(delete3);
    process3.waitFor();

    String e3 = "(SELECT 'Gross Actual Energy (GAE)', 'Total Uncertainty in Energy (UE) (kWh)', 'Gross Estimated Energy (GEE) (kWh)', 'Uncertainty in Energy (Ue)', '% Performance') UNION (SELECT * FROM result3 INTO OUTFILE '"+result3location+"result3.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(e3);
    stmt.close();

    // DOWNLOADING THE FILE FROM THE SERVER 

    String filename3 = "result3.csv";         // FILE NAME //
    String filepath3 = result3location;       // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename3 + "\"");   
  
    java.io.FileInputStream fileInputStream3 = new java.io.FileInputStream(filepath3 + filename3);  
            
    int m;   
    while ((m = fileInputStream3.read()) != -1) {  
    out.write(m);   
    }

    fileInputStream3.close();
	conn.close();
    
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
<%@page import="java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*, javax.servlet.http.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.*, org.apache.commons.io.output.*" %>
