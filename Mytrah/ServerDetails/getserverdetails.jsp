<%@page import="java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*, javax.servlet.http.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.*, org.apache.commons.io.output.*" %>
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
    int dne = 0;

    try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    String templocation = request.getParameter("input1");
    if(templocation.charAt(templocation.length() - 1) == '\\') {
        out.println("<br><b>ERROR!!<br><br>You cannot have a back-slash ( \\ ) at the end of your file path.</b><br>");
        dne = 20;
    }
    if(templocation.contains("\\\\")) {
        out.println("<br><b>ERROR!!<br><br>You cannot have 2 or more consecutive back-slashes ( \\ ) in your file path.</b><br>");
        dne = 20;
    }
    if(templocation.contains("/")) {
        out.println("<br><b>ERROR!!<br><br>You cannot have forward-slashes ( / ) in your file path.</b><br>");
        dne = 20;
    }
    if(templocation.contains(":") != true) {
        out.println("<br><b>ERROR!!<br><br>Your file path is INVALID. It MUST contain a colon ( : ).</b><br>");
        dne = 20;
    }
    if(templocation.contains(" ")) {
        out.println("<br><b>ERROR!!<br><br>Your file path cannot contain empty spaces!</b><br>");
        dne = 20;   
    }
    if(templocation.charAt(0) < 65 || templocation.charAt(0) > 90 ) {
        out.println("<br><b>ERROR!!<br><br>Your file path must start with a capital letter!</b><br>");
        dne = 20;
    }


    String location = templocation.concat("\\").replaceAll("\\\\", "\\\\\\\\\\\\\\\\");

    String str = "DELETE FROM serverconfig;";
    String str1 = "INSERT INTO serverconfig VALUES ('"+location+"', '"+location+"', '"+location+"', '"+location+"', '"+location+"', '"+location+"');";
    stmt = conn.createStatement();
    stmt.executeUpdate(str);
    stmt.executeUpdate(str1);   
    conn.close();
    
    if(dne != 20) {
        String site = new String("/Mytrah/PCGT/index.html");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
    }
    

    }   catch(SQLException se) {
         //Handle errors for JDBC
         se.printStackTrace();
        }  catch(Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
            } finally {

            //finally block used to close resources

            try{
               if(stmt!=null)
               stmt.close();
            }catch(SQLException se2){} // nothing we can do

            try{
               if(conn!=null)
               conn.close();
            }catch(SQLException se){
            se.printStackTrace();
            }//end finally try
        }//end try
%>       