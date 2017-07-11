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

    String[] conditionlist = new String[25];
    int count = 0;
    String[] conditionname = {"windspeed", "winddirection", "temperature", "humidity", "pressure", "power", "manualstop", "turbineavailibility", "gridavailibility", "fault", "rotorrpm", "pitchangle", "frequency", "rain", "upflowangle", "extra1", "extra2", "extra3", "extra4", "extra5"};

    // CREATING AN ARRAY OF APPLIED CONDITIONS

    for(int i = 1; i < 26; i++) {
        String check = request.getParameter("criteria"+i);
        if(check != null) {
            conditionlist[i-1] = check;
            count++;
        } 
    } 

    //FAULT CHECK FILTER

    String fault = request.getParameter("faultcheck");

    if(fault != null){

    String z = "ALTER TABLE rawdata2 ADD mySerial int(11) DEFAULT '0' NOT NULL;";
    String z1 = "SELECT @n:=0;";
    String z2 = "UPDATE rawdata2 SET mySerial = @n := @n + 1;";
    stmt = conn.createStatement();
    stmt.executeUpdate(z);
    stmt.executeQuery(z1);
    stmt.execute(z2);
    stmt.close();

    String z3 = "SELECT t1.mySerial FROM rawdata2 t1 INNER JOIN rawdata2 t2 ON t1.mySerial= t2.mySerial+1 where t2.fault!=0 and t1.turbineavailibility=100";
    stmt = conn.createStatement(); 
    ResultSet rs = stmt.executeQuery(z3);
    while (rs.next()) {

    int srno = rs.getInt("mySerial");
    
    String main = "DELETE FROM rawdata2 WHERE mySerial = "+srno;
    stmt = conn.createStatement();
    stmt.execute(main);
    stmt.close();
    }
    stmt.close();

    String norm = "ALTER TABLE rawdata2 DROP mySerial;";
    stmt = conn.createStatement();
    stmt.execute(norm);
    stmt.close();

    }


    //FILTER LOOP


    for(int j = 1; j <= count; j++) {

    double min = Double.parseDouble(request.getParameter("min"+j));
    double max = Double.parseDouble(request.getParameter("max"+j));

    if(min != max) {

        if(conditionlist[j-1].equals("WIND SPEED")) {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[0]+" <= "+min+" OR "+conditionname[0]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }

        else if(conditionlist[j-1].equals("WIND DIRECTION"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[1]+" <= "+min+" OR "+conditionname[1]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("WIND TEMPERATURE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[2]+" <= "+min+" OR "+conditionname[2]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("HUMIDITY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[3]+" <= "+min+" OR "+conditionname[3]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("PRESSURE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[4]+" <= "+min+" OR "+conditionname[4]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("POWER"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[5]+" <= "+min+" OR "+conditionname[5]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("MANUAL STOP"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[6]+" <= "+min+" OR "+conditionname[6]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("TURBINE AVAILABILITY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[7]+" <= "+min+" OR "+conditionname[7]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("GRID AVAILABILITY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[8]+" <= "+min+" OR "+conditionname[8]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("FAULT"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[9]+" <= "+min+" OR "+conditionname[9]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("ROTOR RPM"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[10]+" <= "+min+" OR "+conditionname[10]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("PITCH ANGLE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[11]+" <= "+min+" OR "+conditionname[11]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("FREQUENCY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[12]+" <= "+min+" OR "+conditionname[12]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("RAIN"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[13]+" <= "+min+" OR "+conditionname[13]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("UP-FLOW ANGLE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[14]+" <= "+min+" OR "+conditionname[14]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 1"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[15]+" <= "+min+" OR "+conditionname[15]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 2"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[16]+" <= "+min+" OR "+conditionname[16]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 3"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[17]+" <= "+min+" OR "+conditionname[17]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 4"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[18]+" <= "+min+" OR "+conditionname[18]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 5"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[19]+" <= "+min+" OR "+conditionname[19]+" >= "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }

        if(conditionlist[j-1] == null)
        break;
    }

    if (min == max) {

        if(conditionlist[j-1].equals("WIND SPEED")) {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[0]+" < "+min+" OR "+conditionname[0]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }

        else if(conditionlist[j-1].equals("WIND DIRECTION"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[1]+" < "+min+" OR "+conditionname[1]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("WIND TEMPERATURE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[2]+" < "+min+" OR "+conditionname[2]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("HUMIDITY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[3]+" < "+min+" OR "+conditionname[3]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("PRESSURE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[4]+" < "+min+" OR "+conditionname[4]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("POWER"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[5]+" < "+min+" OR "+conditionname[5]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("MANUAL STOP"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[6]+" < "+min+" OR "+conditionname[6]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("TURBINE AVAILABILITY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[7]+" < "+min+" OR "+conditionname[7]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("GRID AVAILABILITY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[8]+" < "+min+" OR "+conditionname[8]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("FAULT"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[9]+" < "+min+" OR "+conditionname[9]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("ROTOR RPM"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[10]+" < "+min+" OR "+conditionname[10]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("PITCH ANGLE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[11]+" < "+min+" OR "+conditionname[11]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("FREQUENCY"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[12]+" < "+min+" OR "+conditionname[12]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("RAIN"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[13]+" < "+min+" OR "+conditionname[13]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("UP-FLOW ANGLE"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[14]+" < "+min+" OR "+conditionname[14]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 1"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[15]+" < "+min+" OR "+conditionname[15]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 2"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[16]+" < "+min+" OR "+conditionname[16]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 3"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[17]+" < "+min+" OR "+conditionname[17]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 4"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[18]+" < "+min+" OR "+conditionname[18]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }
        else if(conditionlist[j-1].equals("EXTRA PARAMETER 5"))
        {
        String q = "DELETE FROM rawdata2 WHERE "+conditionname[19]+" < "+min+" OR "+conditionname[19]+" > "+max;
        stmt = conn.createStatement();
        stmt.execute(q);
        stmt.close();
        }

        if(conditionlist[j-1] == null)
        break;

        }
}   

    //EXPORTING THE FILTERED DATA

    String filteredlocation = "";

    String str = "SELECT filtered FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str);
    while(rs.next()) {
        filteredlocation = rs.getString("filtered");
    }
    stmt.close();

    String delete = "cmd /c "+filteredlocation.substring(0,2)+" & cd "+filteredlocation+" & del /Q filtered.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT 'Date', 'Time', 'Wind speed (m/s) (Vi,j)', 'Wind speed_max (m/s)', 'Wind speed_min (m/s)', 'Wind speed_sig (m/s)', 'Wind direction (deg)', 'Temperature (°C) (Ti,j)', 'Temperature_min (°C)', 'Temperature_max(°C)', 'Temperature _SD(°C)', 'Humidity %', 'Pressure (hPa) (Bi,j)', 'Pressure_max (hPa)', 'Pressure_min (hPa)', 'Pressure_SD (hPa)', 'Power (kW) (Pi,j)', 'Power_max (kW)', 'Power_min (kW)', 'Power_SD (kW)', 'Manual Stop', 'Turbine availability', 'Grid availability', 'Fault', 'Rotor RPM', 'Rotor RPM_max', 'Rotor RPM_min', 'Rotor RPM_SD', 'Pitch angle (deg)', 'Pitch angle_max (deg)', 'Pitch angle_min (deg)', 'Pitch angle_SD (deg)', 'Frequency (Hz)', 'Frequency_max (Hz)', 'Frequency_min (Hz)', 'Frequency_SD (Hz)', 'Rain', 'Up Flow Angle', 'Extra1', 'Extra2', 'Extra3', 'Extra4', 'Extra5', 'Cp', 'Turbulence Intensity (TI)', 'Air density (kg/m3) (ρs)', 'Corrected Wind speed (m/s) (Vri,j)', 'Corrected Wind speed_min (m/s)', 'Corrected Wind speed_max (m/s)', 'Corrected Wind speed_sig (m/s)', 'Corrected Pressure (hPa) (Bni,j)', 'Std. Dev') UNION (SELECT * FROM rawdata2 INTO OUTFILE '"+filteredlocation+"filtered.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";    

    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();
    
    //DONWLOADING THE FILE 

    String filename = "filtered.csv";             // FILE NAME //
    String filepath = filteredlocation;           // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
    java.io.FileInputStream fileInputStream = new java.io.FileInputStream(filepath + filename);  
            
    int i;   
    while ((i = fileInputStream.read()) != -1) {  
    out.write(i);   
    }

    fileInputStream.close();
    conn.close();                                                                                                

    String site = new String("/Mytrah/PCGT/index.html");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
    
    }catch(SQLException se){
    //Handle errors for JDBC
    se.printStackTrace();
    }catch(Exception e){
    //HORle errors for Class.forName
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
