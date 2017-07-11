<%@page import="javax.servlet.http.*, java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*" %>


    <!--CODE BY HIGHCHARTS.
        MODIFIED BY SIDDHARTH DHARM.
        LAST UPDATED ON 20/06/2017.
        BITS PILANI HYDERABAD CAMPUS.-->


<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Error Graph</title>

		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<style type="text/css">
${demo.css}
		</style>
	</head>
	<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<%

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";         // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/pcgt";   // URL of your Database //
    final String USER = "root";                                 // Database credentials //
    final String PASS = "";
    Connection conn = null;
    Statement stmt = null;

    double w = 0;
    int rows = 0;
    int i = 0;
    int rowcount = 0;
    StringBuilder powerset = new StringBuilder("[ ");
    StringBuilder speedset = new StringBuilder("[ ");
    StringBuilder unset = new StringBuilder("[ ");
    double[] speed = new double[50];
    double[] power = new double[50];
    double[] uncertainty = new double[50]; 

    try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    String g2 = "SELECT COUNT(poweravg) FROM binneddata WHERE poweravg > 0;";
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery(g2);
    while(rs1.next()){
    int count = rs1.getInt("COUNT(poweravg)");
    rows = count;
    }
    stmt.close();

    String g1 = "SELECT * from binneddata WHERE poweravg > 0;";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(g1);
    i = 0;
    while(rs.next()){

        speed[i] = rs.getDouble("windspeedavg");
        power[i] = rs.getDouble("poweravg");
        DecimalFormat df = new DecimalFormat("#.###");

        if(i==rows-1){
            powerset.append(power[i]);
            speedset.append(df.format(speed[i]));
        }
        else if(i<rows-1){
            powerset.append(power[i]+", ");
            speedset.append(df.format(speed[i])+", "); 
        }
        i++;
    }
    powerset.append(" ]");
    speedset.append(" ]");


    String g4 = "SELECT COUNT(*) FROM result2;";
    stmt = conn.createStatement();
    ResultSet rs3 = stmt.executeQuery(g4);
    while(rs3.next()){
    int count = rs3.getInt("COUNT(*)");
    rowcount = count;
    }
    stmt.close();

    i = 0;
    String g3 = "SELECT combinedstduncertainty FROM result2;";
    stmt = conn.createStatement();
    ResultSet rs2 = stmt.executeQuery(g3);
    while(rs2.next()){

        uncertainty[i] = rs2.getDouble("combinedstduncertainty");
        double neg = power[i] + uncertainty[i];
        double pos = power[i] - uncertainty[i];

        if(i==rowcount-1){
            unset.append("["+neg+", "+pos+"]");
        }
        else if(i<rowcount-1){
            unset.append("["+neg+", "+pos+"], ");
        }
        i++;
    }
    unset.append(" ]");

    stmt.close();
    conn.close();
    
    }catch(SQLException se){
    //out.println(se);
    //Handle errors for JDBC
    se.printStackTrace();
    }catch(Exception e){
    //out.println(e);
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
<div id="container" style="height: 400px; margin: auto; min-width: 310px; max-width: 600px"></div>

    <script type="text/javascript">

Highcharts.chart('container', {
    chart: {
        zoomType: 'xy'
    },
    title: {
        text: 'Binned Power vs. Windspeed'
    },
    xAxis: [{
        categories: <% out.println(speedset); %>
    }],
    yAxis: [{ // Primary yAxis
        labels: {
            format: '{value} kW',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        },
        title: {
            text: 'Binned Power',
            style: {
                color: Highcharts.getOptions().colors[1]
            }
        }
    }],

    tooltip: {
        shared: true
    },

    series: [ {
        name: 'Binned Power',
        type: 'spline',
        data: <% out.println(powerset); %>,
        tooltip: {
            pointFormat: '<span style="font-weight: bold; color: {series.color}">{series.name}</span>: <b>{point.y:.1f}°C</b> '
        }
    }, {
        name: 'Binned Power error',
        type: 'errorbar',
        data: <% out.println(unset); %>,
        tooltip: {
            pointFormat: '(error range: {point.low}-{point.high}°C)<br/>'
        }
    }]
});
        </script>
	</body>
</html>
