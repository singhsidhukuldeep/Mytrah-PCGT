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

    int count = 0;
    double windspeedavg = 0;
    double poweravg = 0;
    double pitchavg = 0;
    double rpmavg = 0;
    double turbulenceavg = 0;
    double cpavg = 0;
    double tiavg = 0;
    double i = 0;
    double j = 0;
    double k = 0;
    double inc = 0;
    double stddev = 0;

    String del = "DELETE FROM binneddata;";
    stmt = conn.createStatement();
    stmt.executeUpdate(del);
    stmt.close();

    String s = request.getParameter("binningrange");
    if(s.equals("1 (Default)")) {
        i = -0.5;
        j = 0.49999;
        k = 0;
        inc = 1;
    }

    else if(s.equals("0.5")) {
        i = -0.25;
        j = 0.24999;
        k = 0;
        inc = 0.5;
    }

    while(i<19) {

        String query = "SELECT COUNT(corrwindspeed) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query1 = "SELECT AVG(corrwindspeed) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query2 = "SELECT AVG(power) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query3 = "SELECT AVG(pitchangle) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query4 = "SELECT AVG(rotorrpm) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query5 = "SELECT AVG(cp) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query6 = "SELECT AVG(ti) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;
        String query7 = "SELECT STDDEV_SAMP(power) FROM rawdata2 WHERE corrwindspeed>="+i+" AND corrwindspeed<="+j;

        stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            int rowcount = rs.getInt("COUNT(corrwindspeed)");
            count = rowcount;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs1 = stmt.executeQuery(query1);
        while (rs1.next()) {
            double avg = rs1.getDouble("AVG(corrwindspeed)");
            windspeedavg = avg;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs2 = stmt.executeQuery(query2);
        while (rs2.next()) {
            double avg = rs2.getDouble("AVG(power)");
            poweravg = avg;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs3 = stmt.executeQuery(query3);
        while (rs3.next()) {
            double avg = rs3.getDouble("AVG(pitchangle)");
            pitchavg = avg;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs4 = stmt.executeQuery(query4);
        while (rs4.next()) {
            double avg = rs4.getDouble("AVG(rotorrpm)");
            rpmavg = avg;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs5 = stmt.executeQuery(query5);
        while (rs5.next()) {
            double avg = rs5.getDouble("AVG(cp)");
            cpavg = avg;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs6 = stmt.executeQuery(query6);
        while (rs6.next()) {
            double avg = rs6.getDouble("AVG(ti)");
            tiavg = avg;
        }
        stmt.close();

        stmt = conn.createStatement();
        ResultSet rs7 = stmt.executeQuery(query7);
        while (rs7.next()) {
            double dev = rs7.getDouble("STDDEV_SAMP(power)");
            stddev = dev;
        }
        stmt.close();
        
        String str1="INSERT INTO binneddata VALUES ("+k+", "+i+", "+j+", "+windspeedavg+", "+poweravg+", "+pitchavg+", "+rpmavg+", "+cpavg+", "+tiavg+", "+count+", "+stddev+")";

        stmt = conn.createStatement();
        stmt.executeUpdate(str1);
        stmt.close();

        i = i + inc;
        j = j + inc;
        k = k + inc;
    }
   
    //EXPORTING THE FILE

    String binnedlocation = "";

    String str = "SELECT binned FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs8 = stmt.executeQuery(str);
    while(rs8.next()) {
        binnedlocation = rs8.getString("binned");
    }
    stmt.close();    

    String delete = "cmd /c "+binnedlocation.substring(0,2)+" & cd "+binnedlocation+" & del /Q binneddata.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT 'Speed Bin', 'Binning Range_Min', 'Binning Range_Max', 'Wind Speed', 'Power', 'Pitch', 'RPM', 'Cp', 'Turbulence', 'Count') UNION (SELECT speedbin, speedbinmin, speedbinmax, windspeedavg, poweravg, pitchavg, rpmavg, cpavg, turbulenceavg, count FROM binneddata INTO OUTFILE '"+binnedlocation+"binneddata.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();

    //DOWNLOADING THE FILE    

    String filename = "binneddata.csv";     // FILE NAME //
    String filepath = binnedlocation;       // FILE PATH //  
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
    java.io.FileInputStream fileInputStream = new java.io.FileInputStream(filepath + filename);  
            
    int x;   
    while ((x = fileInputStream.read()) != -1) {  
    out.write(x);   
    }

    fileInputStream.close();

    conn.close();

    /*String site = new String("/Mytrah/PCGT/index.html");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);*/
    
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




