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
    String result3location = "";

    try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    //EXPORTING UNCERTAINTY DATA ONTO SERVER FROM MySQL

    String uncertaintylocation = "";

    String str = "SELECT rawdata FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        uncertaintylocation = rs.getString("rawdata");
    }
    stmt.close(); 

    String delete = "cmd /c "+uncertaintylocation.substring(0,2)+" & cd "+uncertaintylocation+" & del /Q uncertainty.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT '(Pn) (kW)', '(Ucl)', '(Uvl)', '(Upl)', '(Ud1)', '(Pmr) (kW)', '(UPT) (kW)', '(Udp) (kW)', '(Ud2)', '(Vmr) (m/s)', '(Uac) (m/s)', '(Uf)', '(k)', '(Um)', '(Udv) (m/s)', '(Ud3)', '(Tmr) (K)', '(Uts)', '(Urt)', '(Umot)', '(Udt)', '(Ud4)', '(Prmr) (hPa)', '(UPrc) (hPa)', '(UmtPr) (hPa)') UNION (SELECT * FROM uncertainty INTO OUTFILE '"+uncertaintylocation+"uncertainty.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";
    
    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();

    // DOWNLOADING THE FILE FROM THE SERVER   

    String filename = "uncertainty.csv";         // FILE NAME //
    String filepath = uncertaintylocation;       // FILE PATH //  
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
