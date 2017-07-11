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

    String filteredlocation = "";

    String str = "SELECT filtered FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        filteredlocation = rs.getString("filtered");
    }
    stmt.close(); 

    // EXPORTING TABLE ONTO SERVER FROM MySQL 

    String delete = "cmd /c "+filteredlocation.substring(0,2)+" & cd "+filteredlocation+" & del /Q filtered.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT 'Date', 'Time', 'Wind speed (m/s) (Vi,j)', 'Wind speed_max (m/s)', 'Wind speed_min (m/s)', 'Wind speed_sig (m/s)', 'Wind direction (deg)', 'Temperature (°C) (Ti,j)', 'Temperature_min (°C)', 'Temperature_max(°C)', 'Temperature _SD(°C)', 'Humidity %', 'Pressure (hPa) (Bi,j)', 'Pressure_max (hPa)', 'Pressure_min (hPa)', 'Pressure_SD (hPa)', 'Power (kW) (Pi,j)', 'Power_max (kW)', 'Power_min (kW)', 'Power_SD (kW)', 'Manual Stop', 'Turbine availability', 'Grid availability', 'Fault', 'Rotor RPM', 'Rotor RPM_max', 'Rotor RPM_min', 'Rotor RPM_SD', 'Pitch angle (deg)', 'Pitch angle_max (deg)', 'Pitch angle_min (deg)', 'Pitch angle_SD (deg)', 'Frequency (Hz)', 'Frequency_max (Hz)', 'Frequency_min (Hz)', 'Frequency_SD (Hz)', 'Rain', 'Up Flow Angle', 'Extra1', 'Extra2', 'Extra3', 'Extra4', 'Extra5', 'Cp', 'Turbulence Intensity (TI)', 'Air density (kg/m3) (ρs)', 'Corrected Wind speed (m/s) (Vri,j)', 'Corrected Wind speed_min (m/s)', 'Corrected Wind speed_max (m/s)', 'Corrected Wind speed_sig (m/s)', 'Corrected Pressure (hPa) (Bni,j)', 'Std. Dev') UNION (SELECT * FROM rawdata2 INTO OUTFILE '"+filteredlocation+"filtered.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";    

    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();

    // DOWNLOADING THE FILE FROM THE SERVER 

    String filename = "filtered.csv";             // FILE NAME //
    String filepath = filteredlocation;           // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
    java.io.FileInputStream fileInputStream = new java.io.FileInputStream(filepath + filename);  
            
    int i;   
    while ((i=fileInputStream.read()) != -1) {  
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
