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

    String str = request.getParameter("pn");
    String str1 = request.getParameter("ucl");
    String str2 = request.getParameter("uvl");
    String str3 = request.getParameter("upl");
    String str4 = request.getParameter("ud1");
    String str5 = request.getParameter("pmr");
    String str6 = request.getParameter("upt");
    String str7 = request.getParameter("udp");
    String str8 = request.getParameter("ud2");
    String str9 = request.getParameter("vmr");
    String str10 = request.getParameter("uac");
    String str11 = request.getParameter("uf");
    String str12 = request.getParameter("udv");
    String str13 = request.getParameter("ud3");
    String str14 = request.getParameter("tmr");
    String str15 = request.getParameter("uts");
    String str16 = request.getParameter("urt");
    String str17 = request.getParameter("umot");
    String str18 = request.getParameter("udt");
    String str19 = request.getParameter("ud4");
    String str20 = request.getParameter("prmr");
    String str21 = request.getParameter("uprc");
    String str22 = request.getParameter("umtpr");
    String str23 = request.getParameter("k");
    String str24 = request.getParameter("um");

    String del = "DELETE FROM uncertainty";
    String str28 = "INSERT INTO uncertainty VALUES ("+str+", "+str1+", "+str2+", "+str3+", "+str4+", "+str5+", "+str6+", "+str7+", "+str8+", "+str9+", "+str10+", "+str11+", "+str23+", "+str24+", "+str12+", "+str13+", "+str14+", "+str15+", "+str16+", "+str17+", "+str18+", "+str19+", "+str20+", "+str21+", "+str22+");";

    stmt = conn.createStatement();
    stmt.executeUpdate(del);
    stmt.executeUpdate(str28);
    stmt.close();

    //EXPORTING UNCERTAINTY DATA

    String uncertaintylocation = "";

    String str26 = "SELECT rawdata FROM serverconfig;";
    stmt = conn.createStatement();
    ResultSet rs26 = stmt.executeQuery(str26);
    while(rs26.next()) {
        uncertaintylocation = rs26.getString("rawdata");
    }
    stmt.close();

    String delete = "cmd /c "+uncertaintylocation.substring(0,2)+" & cd "+uncertaintylocation+" & del /Q uncertainty.csv";
    Process process = Runtime.getRuntime().exec(delete);
    process.waitFor();

    String export = "(SELECT '(Pn) (kW)', '(Ucl)', '(Uvl)', '(Upl)', '(Ud1)', '(Pmr) (kW)', '(UPT) (kW)', '(Udp) (kW)', '(Ud2)', '(Vmr) (m/s)', '(Uac) (m/s)', '(Uf)', '(k)', '(Um)', '(Udv) (m/s)', '(Ud3)', '(Tmr) (K)', '(Uts)', '(Urt)', '(Umot)', '(Udt)', '(Ud4)', '(Prmr) (hPa)', '(UPrc) (hPa)', '(UmtPr) (hPa)') UNION (SELECT * FROM uncertainty INTO OUTFILE '"+uncertaintylocation+"uncertainty.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\r\\n');";
    
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

