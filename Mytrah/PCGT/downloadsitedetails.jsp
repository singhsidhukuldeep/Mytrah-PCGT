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

    //EXPORTING THE FILE

    String sitedetailslocation = "";

    String str = "SELECT rawdata FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        sitedetailslocation = rs.getString("rawdata");
    }
    stmt.close();    

    String delete = "cmd /c "+sitedetailslocation.substring(0,2)+" & cd "+sitedetailslocation+" & del /Q sitedetails.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT 'Site Name', 'Measurement Period (FROM)', 'Measurement Period (TO)', 'Test Turbine', 'Make', 'Turbine Model', 'Turbine Capacity', 'Rotor Diameter (m)', 'Hub Height (m)', 'Test Turbine Location', 'Reference Mast Location', 'Pressure Sensor Height', 'Turbine Altitude') UNION (SELECT * FROM rawsitedetails INTO OUTFILE '"+sitedetailslocation+"sitedetails.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();   

    String filename = "sitedetails.csv";         // FILE NAME //
    String filepath = sitedetailslocation;       // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
    java.io.FileInputStream fileInputStream = new java.io.FileInputStream(filepath + filename);  
            
    int i;   
    while ((i = fileInputStream.read()) != -1) {  
    out.write(i);   
    }

    fileInputStream.close();
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
