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

    String result2location = "";

	String str = "SELECT result2 FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        result2location = rs.getString("result2");
    }
    stmt.close();

    // EXPORTING TABLE ONTO SERVER FROM MySQL    

    String delete2 = "cmd /c "+result2location.substring(0,2)+" & cd "+result2location+" & del /Q result2.csv";
    Process process2 = Runtime.getRuntime().exec(delete2);
    process2.waitFor();

    String e2 = "(SELECT 'Speed Bin', 'Standard Power (Pri)', 'Measured Power (Pi)', 'Frequency (Fi)', 'Combined Std. Uncertainty (U)', 'Actual Energy (Ea)', 'Estimated Energy (Ee)', 'Uncertainty in Energy (Eue)') UNION (SELECT * FROM result2 INTO OUTFILE '"+result2location+"result2.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(e2);
    stmt.close();

    // DOWNLOADING THE FILE FROM THE SERVER 

    String filename2 = "result2.csv";         // FILE NAME //
    String filepath2 = result2location;       // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename2 + "\"");   
  
    java.io.FileInputStream fileInputStream2 = new java.io.FileInputStream(filepath2 + filename2);  
            
    int l;   
    while ((l = fileInputStream2.read()) != -1) {  
    out.write(l);   
    }

    fileInputStream2.close();
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
