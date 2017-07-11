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

    String binnedlocation = "";

    String str = "SELECT binned FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        binnedlocation = rs.getString("binned");
    }
    stmt.close();

    // EXPORTING TABLE ONTO SERVER FROM MySQL    

    String delete = "cmd /c "+binnedlocation.substring(0,2)+" & cd "+binnedlocation+" & del /Q binneddata.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT 'Speed Bin', 'Binning Range_Min', 'Binning Range_Max', 'Wind Speed', 'Power', 'Pitch', 'RPM', 'Cp', 'Turbulence', 'Count') UNION (SELECT speedbin, speedbinmin, speedbinmax, windspeedavg, poweravg, pitchavg, rpmavg, cpavg, turbulenceavg, count FROM binneddata INTO OUTFILE '"+binnedlocation+"binneddata.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();

    // DOWNLOADING THE FILE FROM THE SERVER    

    String filename = "binneddata.csv";     // FILE NAME //
    String filepath = binnedlocation;       // FILE PATH //  
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