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

    String result1location = "";

	String str = "SELECT result1 FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        result1location = rs.getString("result1");
    }
    stmt.close();   

    // EXPORTING TABLE ONTO SERVER FROM MySQL

    String delete1 = "cmd /c "+result1location.substring(0,2)+" & cd "+result1location+" & del /Q result1.csv";
    Process process1 = Runtime.getRuntime().exec(delete1);
    process1.waitFor();

    String e1 = "(SELECT 'Speed Bin', 'Binning Range_Min', 'Binning Range_Max', 'Wind Speed (Vi)', 'Measured Power (Pi)', 'Count (Ni)', 'Upi', 'Uvi', 'Ut', 'Ub', 'Ui', 'Si', 'U') UNION (SELECT * FROM result1 INTO OUTFILE '"+result1location+"result1.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(e1);
    stmt.close();

    // DOWNLOADING THE FILE FROM THE SERVER  

    String filename1 = "result1.csv";         // FILE NAME //
    String filepath1 = result1location;       // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename1 + "\"");   
  
    java.io.FileInputStream fileInputStream1 = new java.io.FileInputStream(filepath1 + filename1);  
            
    int n;   
    while ((n = fileInputStream1.read()) != -1) {  
    out.write(n);   
    }

    fileInputStream1.close();
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
