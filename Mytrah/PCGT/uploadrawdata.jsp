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
   
   File file;
   int maxFileSize = 100000000 * 100000000;
   int maxMemSize = 100000000 * 100000000;
   String rawdatalocation = "";

   try {

      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(DB_URL,USER,PASS);

      String str = "SELECT rawdata FROM serverconfig;";
      stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery(str);
      while(rs.next()) {
         rawdatalocation = rs.getString("rawdata");
      }
      stmt.close(); 
      conn.close();

   }  catch(SQLException se) {
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


   //DELETING EXISTING FILES ON SERVER
     
   String delete = "cmd /c E: & cd "+rawdatalocation+" & del /Q rawdata.csv";   
   Process process = Runtime.getRuntime().exec(delete);
   process.waitFor();

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize. 
      factory.setRepository(new File(rawdatalocation));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");

         String fileName2 = "o";

         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  
            {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               fileName2=fileName;
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ){
                  file = new File(rawdatalocation + 
                  fileName.substring( fileName.lastIndexOf("\\")));
               } else {
                  file = new File(rawdatalocation + 
                  fileName.substring(fileName.lastIndexOf("\\")+1));
               }
               fi.write(file);
            }
         }
         out.println("</body>");
         out.println("</html>");

         String rename = "cmd /c "+rawdatalocation.substring(0,2)+" & cd "+rawdatalocation+" & ren \""+fileName2+"\" rawdata.csv";
         Process process1 = Runtime.getRuntime().exec(rename);
         process1.waitFor();

         String site = new String("/Mytrah/PCGT/index.html");
         response.setStatus(response.SC_MOVED_TEMPORARILY);
         response.setHeader("Location", site);

      }catch(Exception ex) {
         System.out.println(ex);
      }

   } else {
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }   


   try {

      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(DB_URL,USER,PASS);

      String del1 = "DELETE FROM rawdata1;";
      String del2 = "DELETE FROM rawdata2;";
      String up1 ="LOAD DATA LOCAL INFILE '"+rawdatalocation+"rawdata.csv' INTO TABLE rawdata1 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;";
      String up2 ="LOAD DATA LOCAL INFILE '"+rawdatalocation+"rawdata.csv' INTO TABLE rawdata2 FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;";     
      stmt = conn.createStatement();
      stmt.executeUpdate(del1);
      stmt.executeUpdate(del2);
      stmt.executeUpdate(up1);
      stmt.executeUpdate(up2);
      stmt.close();
      conn.close();

   }  catch(SQLException se) {
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