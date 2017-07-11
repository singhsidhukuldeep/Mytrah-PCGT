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

    double r = 0;
    double rho = 0;
    double hs = 0;
    double a = 0;
    double hub = 0;

    //FORM DETAILS HANDLING

    String str = request.getParameter("sitename");
    String str1 = request.getParameter("fromdate");
    String str2 = request.getParameter("todate");
    String str3 = request.getParameter("testturbine");
    String str4 = request.getParameter("make");
    String str5 = request.getParameter("turbinemodel");
    String str6 = request.getParameter("turbinecapacity");
    String str7 = request.getParameter("rotordiameter");
    String str8 = request.getParameter("hubheight");
    String str9 = request.getParameter("testturbinelocation");
    String str10 = request.getParameter("referencemastlocation");
    String str11 = request.getParameter("presensorheight");
    String str12 = request.getParameter("turbinealtitude");

    String del4 = "DELETE FROM rawsitedetails;";
    String str13 = "INSERT INTO rawsitedetails VALUES ('"+str+"','"+str1+"','"+str2+"','"+str3+"','"+str4+"','"+str5+"','"+str6+"','"+str7+"','"+str8+"','"+str9+"','"+str10+"','"+str11+"','"+str12+"');";

    stmt = conn.createStatement();
    stmt.executeUpdate(del4);
    stmt.executeUpdate(str13);
    stmt.close();

    //APPENDING THE ADDITIONAL PARAMETERS

    String str14 = "SELECT rotor_diameter FROM rawsitedetails";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(str14);
    while(rs.next()) {
        double rotrad = rs.getDouble("rotor_diameter");
        r = rotrad/2;
    }
    stmt.close();

    String str15 = "SELECT presensorheight FROM rawsitedetails";
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery(str15);
    while(rs1.next()) {
        double hs1 = rs1.getDouble("presensorheight");
        hs = hs1;
    }
    stmt.close();

    String str16 = "SELECT turbinealtitude FROM rawsitedetails";
    stmt = conn.createStatement();
    ResultSet rs2 = stmt.executeQuery(str16);
    while(rs2.next()) {
        double a1 = rs2.getDouble("turbinealtitude");
        a = a1;
    }
    stmt.close();

    String str17 = "SELECT hub_height FROM rawsitedetails";
    stmt = conn.createStatement();
    ResultSet rs3 = stmt.executeQuery(str17);
    while(rs3.next()) {
        double hub1 = rs3.getDouble("hub_height");
        hub = hub1;
    }
    stmt.close();

    double hsn = hs + a;
    double hsnc = hub + a;
    double bsn = java.lang.Math.pow((3.73144 - (0.0000841728 * hsn)),5.25588);
    double bsnc = java.lang.Math.pow((3.73144 - (0.0000841728 * hsnc)),5.25588);
    double kb = bsnc - bsn;

    String str18 = "UPDATE rawdata2 SET corrpressure = pressure + "+kb; 
    String str19 = "UPDATE rawdata2 SET rho = corrpressure * 100 / (287.05 * (temperature + 273))";
    String str20 = "UPDATE rawdata2 SET ti = windspeed_sig/windspeed";
    String str21 = "UPDATE rawdata2 SET corrwindspeed = windspeed * pow((rho/1.225),(1/3))";
    String str22 = "UPDATE rawdata2 SET cp = power * 2000 / (3.14159 * rho * pow("+r+",2) * pow(corrwindspeed,3))";
    String str23 = "UPDATE rawdata2 SET corrwindspeedmin = windspeed_min * pow((rho/1.225),(1/3))";
    String str24 = "UPDATE rawdata2 SET corrwindspeedmax = windspeed_max * pow((rho/1.225),(1/3))";
    String str25 = "UPDATE rawdata2 SET corrwindspeedsig = windspeed_sig * pow((rho/1.225),(1/3))";

    stmt = conn.createStatement();
    stmt.execute(str18);
    stmt.execute(str19);
    stmt.execute(str20);
    stmt.execute(str21);
    stmt.execute(str22);
    stmt.execute(str23);
    stmt.execute(str24);
    stmt.execute(str25);
    stmt.close();


    // EXPORTING SITE DETAILS TABLE ONTO SERVER FROM MySQL


    String sitedetailslocation = "";

    String str26 = "SELECT rawdata FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs26 = stmt.executeQuery(str26);
    while(rs26.next()) {
        sitedetailslocation = rs26.getString("rawdata");
    }
    stmt.close();

    String delete = "cmd /c "+sitedetailslocation.substring(0,2)+" & cd "+sitedetailslocation+" & del /Q sitedetails.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT 'Site Name', 'Measurement Period (FROM)', 'Measurement Period (TO)', 'Test Turbine', 'Make', 'Turbine Model', 'Turbine Capacity', 'Rotor Diameter (m)', 'Hub Height (m)', 'Test Turbine Location', 'Reference Mast Location', 'Pressure Sensor Height', 'Turbine Altitude') UNION (SELECT * FROM rawsitedetails INTO OUTFILE '"+sitedetailslocation+"sitedetails.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";
    
    stmt = conn.createStatement();
    stmt.executeQuery(export);
    stmt.close();

    conn.close();
 
    String site = new String("/Mytrah/PCGT/index.html");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
    
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


