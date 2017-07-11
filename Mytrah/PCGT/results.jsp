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

    double pn = 0, upl = 0, ud1 = 0, pmr = 0, vmr = 0, ud2 = 0, ud3 = 0, ucl = 0, uf = 0, uac = 0, k = 0, prmr = 0, ud4 = 0;
    double um = 0, uts = 0, urt = 0, umot = 0, udt = 0, uprc = 0, umtpr = 0, udpr = 0, gae = 0, tue = 0, gee = 0, ue = 0, pp = 0;
    
    String delete4 = "DELETE FROM result1";
    String delete5 = "DELETE FROM result2";
    String delete6 = "DELETE FROM inter1";
    String delete7 = "DELETE FROM result3";
    stmt = conn.createStatement();
    stmt.executeUpdate(delete4);
    stmt.executeUpdate(delete5);
    stmt.executeUpdate(delete6);
    stmt.executeUpdate(delete7);   
    stmt.close();

    //UPDATING INTERMEDIATE TABLE

    String s1 = "INSERT INTO inter1 (binspeed, pdiff, wdiff) SELECT speedbin, poweravg, windspeedavg FROM binneddata WHERE speedbin = 0";
    String s2 = "INSERT INTO inter1 (binspeed, pdiff, wdiff) SELECT g1.speedbin+1, (g2.poweravg - g1.poweravg) AS pdiff, (g2.windspeedavg - g1.windspeedavg) AS pdiff FROM binneddata g1 INNER JOIN binneddata g2 ON g2.speedbin = g1.speedbin + 1";
    String s3 = "UPDATE inter1 SET cvi = pdiff/wdiff";
    
    stmt = conn.createStatement();
    stmt.executeUpdate(s1);
    stmt.executeUpdate(s2);
    stmt.execute(s3);
    stmt.close();

    //GETTING PARAMETERS FOR ENERGY CALCULATIONS

    String query= "SELECT * FROM uncertainty";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(query);
    while(rs.next()){
    double pn1 = rs.getDouble("pn");
    pn = pn1;
    double upl1 = rs.getDouble("upl");
    upl = upl1/100;
    double udd1 = rs.getDouble("ud1");
    ud1 = udd1/100;
    double pmr1 = rs.getDouble("pmr");
    pmr = pmr1;
    double vmr1 = rs.getDouble("vmr");
    vmr = vmr1;
    double udd2 = rs.getDouble("ud2");
    ud2 = udd2/100;
    double udd3 = rs.getDouble("ud3");
    ud3 = udd3/100;
    double ucl1 = rs.getDouble("ucl");
    ucl = ucl1/100;
    double uf1 = rs.getDouble("uf");
    uf = uf1/100;
    double uac1 = rs.getDouble("uac");
    uac = uac1;
    double k1 = rs.getDouble("k");
    k = k1;
    double um1 = rs.getDouble("um");
    um = um1/100;
    double udd4 = rs.getDouble("ud4");
    ud4 = udd4/100;
    double prmr1 = rs.getDouble("prmr");
    prmr = prmr1;
    double uts1 = rs.getDouble("uts");
    uts = uts1;
    double urt1 = rs.getDouble("urt");
    urt = urt1;
    double umot1 = rs.getDouble("umot");
    umot = umot1;
    double udt1 = rs.getDouble("udt");
    udt = udt1;
    double uprc1 = rs.getDouble("uprc");
    uprc = uprc1;
    double umtpr1 = rs.getDouble("umtpr");
    umtpr = umtpr1;
    }
    stmt.close();

    double upt = pn*upl/1.73205; 

    double udp = ud1 * pmr;

    double udv = ud2 * vmr;

    udpr = ud4 * prmr;


    //UPDATING RESULT1 TABLE


    String add = "ALTER TABLE result1 ADD cvi double DEFAULT '0';";

    String ins1 = "INSERT INTO result1 (binspeed, minspeedbin, maxspeedbin, windspeedresult, powerresult, countresult, unpoweraresult, cvi) SELECT binneddata.speedbin, binneddata.speedbinmin, binneddata.speedbinmax, binneddata.windspeedavg, binneddata.poweravg, binneddata.count, binneddata.stddev/(pow(binneddata.count,0.5)), inter1.cvi FROM binneddata INNER JOIN inter1 ON binneddata.speedbin = inter1.binspeed;";

    String str1 = "UPDATE result1 SET unpowerbresult = SQRT (pow(("+ucl+" * powerresult / pow (3,0.5)),2) + pow("+upt+",2) + pow("+udp+",2));";

    String str2 = "UPDATE result1 SET unwindspeedbresult = SQRT (pow("+uac+",2) + pow(((0.05+0.005*windspeedresult)*"+k+"),2)/3 + pow("+um+"*windspeedresult,2) + pow("+uf+"*windspeedresult,2) + pow("+udv+",2));";

    String str3 = "UPDATE result1 SET untempbresult = SQRT (pow("+uts+",2) + pow("+urt+",2) + pow("+umot+",2) + pow("+udt+",2));";

    String str4 = "UPDATE result1 SET unpressurebresult = SQRT (pow("+uprc+",2) + pow("+umtpr+",2) + pow("+udpr+",2));";

    String str5 = "UPDATE result1 SET combinedbunresult = SQRT (pow(unpowerbresult,2) + pow((cvi),2) * pow(unwindspeedbresult,2) + pow((powerresult/288.15),2) * pow(untempbresult,2) + pow((powerresult/1013),2) * pow(unpressurebresult,2));";

    String str6 = "UPDATE result1 SET uncertaintycombined = SQRT (pow(unpoweraresult,2) + pow(combinedbunresult,2));";

    String str7 = "ALTER TABLE result1 DROP cvi;";

    String str8 = "DELETE FROM result1 WHERE countresult < 3;";

    stmt = conn.createStatement();
    stmt.executeUpdate(add);
    stmt.executeUpdate(ins1);
    stmt.execute(str1);
    stmt.execute(str2);
    stmt.execute(str3);
    stmt.execute(str4);
    stmt.execute(str5);
    stmt.execute(str6);
    stmt.execute(str7);
    stmt.execute(str8);
    stmt.close();


    //UPDATING RESULT2 TABLE


    String ins4 = "INSERT INTO result2 (binspeed, stdpowerresult,frequencyresult,measuredpowerresult, combinedstduncertainty) SELECT staticpower.statwindspeed, staticpower.statpower, staticfrequency.statfrequency2, result1.powerresult, result1.uncertaintycombined FROM staticpower INNER JOIN staticfrequency ON staticpower.statwindspeed=staticfrequency.statwindspeed2 INNER JOIN result1 ON staticpower.statwindspeed=result1.binspeed;";

    String r1 = "UPDATE result2 SET actualenergyresult = measuredpowerresult * frequencyresult * 8760";
    String r2 = "UPDATE result2 SET estenergyresult = stdpowerresult * frequencyresult * 8760";
    String r3 = "UPDATE result2 SET unenergyresult = combinedstduncertainty * frequencyresult * 8760";
    String r4 = "DELETE FROM result2 where measuredpowerresult = 0;";
    
    stmt = conn.createStatement();
    stmt.executeUpdate(ins4);
    stmt.execute(r1);
    stmt.execute(r2);
    stmt.execute(r3);
    stmt.execute(r4);
    stmt.close(); 


    //UPDATING RESULT3 TABLE


    String query1 = "SELECT SUM(actualenergyresult) FROM result2";
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery(query1);
    while(rs1.next()){
    double gae1 = rs1.getDouble("SUM(actualenergyresult)");
    gae = gae1;
    }
    stmt.close();

    String query2 = "SELECT SUM(unenergyresult) FROM result2";
    stmt = conn.createStatement();
    ResultSet rs2 = stmt.executeQuery(query2);
    while(rs2.next()){
    double tue1 = rs2.getDouble("SUM(unenergyresult)");
    tue = tue1;
    }
    stmt.close();

    String query3 = "SELECT SUM(estenergyresult) FROM result2";
    stmt = conn.createStatement();
    ResultSet rs3 = stmt.executeQuery(query3);
    while(rs3.next()){
    double gee1 = rs3.getDouble("SUM(estenergyresult)");
    gee = gee1;
    }
    stmt.close();

    String query4 = "INSERT INTO result3 VALUES ('"+gae+"', '"+tue+"', '"+gee+"', '0', '0')";
    String query5 = "UPDATE result3 SET UE = (100*TUE)/GAE";
    String query6 = "UPDATE result3 SET PP = (100*GAE)/GEE";

    stmt = conn.createStatement();
    stmt.execute(query4);
    stmt.execute(query5);
    stmt.execute(query6);
    stmt.close();


    //EXPORTING THE RESULTS ONTO SERVER FROM MySQL


    String result1location = "";
    String result2location = "";
    String result3location = "";

    String str11 = "SELECT result1, result2, result3 FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs11 = stmt.executeQuery(str11);
    while(rs11.next()) {
        result1location = rs11.getString("result1");
        result2location = rs11.getString("result2");
        result3location = rs11.getString("result3");
    }
    stmt.close();

    String delete1 = "cmd /c "+result1location.substring(0,2)+" & cd "+result1location+" & del /Q result1.csv";
    String delete2 = "cmd /c "+result2location.substring(0,2)+" & cd "+result2location+" & del /Q result2.csv";
    String delete3 = "cmd /c "+result3location.substring(0,2)+" & cd "+result3location+" & del /Q result3.csv";
    Process process1 = Runtime.getRuntime().exec(delete1);
    process1.waitFor();
    Process process2 = Runtime.getRuntime().exec(delete2);
    process2.waitFor();
    Process process3 = Runtime.getRuntime().exec(delete3);
    process3.waitFor();

    String e1 = "(SELECT 'Speed Bin', 'Binning Range_Min', 'Binning Range_Max', 'Wind Speed (Vi)', 'Measured Power (Pi)', 'Count (Ni)', 'Upi', 'Uvi', 'Ut', 'Ub', 'Ui', 'Si', 'U') UNION (SELECT * FROM result1 INTO OUTFILE '"+result1location+"result1.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";
    String e2 = "(SELECT 'Speed Bin', 'Standard Power (Pri)', 'Measured Power (Pi)', 'Frequency (Fi)', 'Combined Std. Uncertainty (U)', 'Actual Energy (Ea)', 'Estimated Energy (Ee)', 'Uncertainty in Energy (Eue)') UNION (SELECT * FROM result2 INTO OUTFILE '"+result2location+"result2.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";
    String e3 = "(SELECT 'Gross Actual Energy (GAE)', 'Total Uncertainty in Energy (UE) (kWh)', 'Gross Estimated Energy (GEE) (kWh)', 'Uncertainty in Energy (Ue)', '% Performance') UNION (SELECT * FROM result3 INTO OUTFILE '"+result3location+"result3.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";

    stmt = conn.createStatement();
    stmt.executeQuery(e1);
    stmt.executeQuery(e2);
    stmt.executeQuery(e3);
    stmt.close();


    //DOWNLOADING THE FINAL RESULT3 TABLE
    

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
