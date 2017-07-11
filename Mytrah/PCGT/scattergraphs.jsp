<%@page import="javax.servlet.http.*, java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*" %>


    <!--CODE BY HIGHCHARTS.
        MODIFIED BY SIDDHARTH DHARM.
        LAST UPDATED ON 20/06/2017.
        BITS PILANI HYDERABAD CAMPUS.-->


<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Scatter Graphs</title>

		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<style type="text/css">
${demo.css}
		</style>
	</head>
	<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<%

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";         // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/pcgt";   // URL of your Database //
    final String USER = "root";                                 // Database credentials //
    final String PASS = "";
    Connection conn = null;
    Statement stmt = null;
    String result3location = "";

    double w = 0;
    int rows = 0;
    int i = 0;
    StringBuilder set = new StringBuilder("[ ");
    StringBuilder set1 = new StringBuilder("[ ");
    StringBuilder set2 = new StringBuilder("[ ");
    StringBuilder set3 = new StringBuilder("[ ");
    StringBuilder set4 = new StringBuilder("[ ");
    StringBuilder set5 = new StringBuilder("[ ");
    StringBuilder set6 = new StringBuilder("[ ");
    StringBuilder set7 = new StringBuilder("[ ");
    StringBuilder set8 = new StringBuilder("[ ");
    StringBuilder set9 = new StringBuilder("[ ");
    StringBuilder set10 = new StringBuilder("[ ");
    StringBuilder set11 = new StringBuilder("[ ");

    try{

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    String g2 = "SELECT COUNT(*) FROM binneddata";
    stmt = conn.createStatement();
    ResultSet rs1 = stmt.executeQuery(g2);
    while(rs1.next()){
    int count = rs1.getInt("COUNT(*)");
    rows = count;
    }
    stmt.close();

    String g1 = "SELECT * from binneddata";
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(g1);
    i = 0;
    while(rs.next()){

    double windspeedavg = rs.getDouble("windspeedavg");
    double power = rs.getDouble("poweravg");
    double stddev = rs.getDouble("stddev");
    
    if(i==rows-1){
    set.append("["+windspeedavg+", "+power+"] ");
    set1.append("["+windspeedavg+", "+stddev+"] ");
    }
    else if(i<rows-1){
    set.append("["+windspeedavg+", "+power+"], ");
    set1.append("["+windspeedavg+", "+stddev+"], "); 
    }
    
    i++;

    }
    set.append(" ]");
    set1.append(" ]");

    stmt.close();


    String g3 = "SELECT COUNT(*) FROM rawdata2";
    stmt = conn.createStatement();
    ResultSet rs2 = stmt.executeQuery(g3);
    while(rs2.next()){
    int count = rs2.getInt("COUNT(*)");
    rows = count;
    }
    stmt.close();

    i = 0;
    String g4 = "SELECT * from rawdata2";
    stmt = conn.createStatement();
    ResultSet rs3 = stmt.executeQuery(g4);
    while(rs3.next()){

    double powermin = rs3.getDouble("power_min");
    double windspeed = rs3.getDouble("windspeed");
    double powermax = rs3.getDouble("power_max");
    double pitch = rs3.getDouble("pitchangle");
    double cp = rs3.getDouble("cp");
    double gridfrequency = rs3.getDouble("frequency");
    double rotorrpm = rs3.getDouble("rotorrpm");
    double rotorrpm_sd = rs3.getDouble("rotorrpm_sd");
    double turbulenceintensity = rs3.getDouble("ti");
    double temp = rs3.getDouble("temperature");
    double pressure = rs3.getDouble("pressure");

    if(i==rows-1){
    set2.append("["+windspeed+", "+powermin+"] ");
    set3.append("["+windspeed+", "+powermax+"] ");
    set4.append("["+windspeed+", "+pitch+"] ");
    set5.append("["+windspeed+", "+cp+"] ");
    set6.append("["+windspeed+", "+gridfrequency+"] ");
    set7.append("["+windspeed+", "+rotorrpm+"] ");
    set8.append("["+windspeed+", "+rotorrpm_sd+"] ");
    set9.append("["+windspeed+", "+turbulenceintensity+"] ");
    set10.append("["+windspeed+", "+temp+"] ");
    set11.append("["+windspeed+", "+pressure+"] ");

    }
    else if(i<rows-1){
    set2.append("["+windspeed+", "+powermin+"], ");
    set3.append("["+windspeed+", "+powermax+"], ");
    set4.append("["+windspeed+", "+pitch+"], ");
    set5.append("["+windspeed+", "+cp+"], ");
    set6.append("["+windspeed+", "+gridfrequency+"], ");
    set7.append("["+windspeed+", "+rotorrpm+"], ");
    set8.append("["+windspeed+", "+rotorrpm_sd+"], ");
    set9.append("["+windspeed+", "+turbulenceintensity+"], ");
    set10.append("["+windspeed+", "+temp+"], ");
    set11.append("["+windspeed+", "+pressure+"], ");

    }
    
    i++;

    }
    set2.append(" ]");
    set3.append(" ]");
    set4.append(" ]");
    set5.append(" ]");
    set6.append(" ]");
    set7.append(" ]");
    set8.append(" ]");
    set9.append(" ]");
    set10.append(" ]");
    set11.append(" ]");

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

<div id="container" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>

		<script type="text/javascript">

Highcharts.chart('container', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Binned Wind Speed vs. Power'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Power (kW)'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Power Mean',
        color: 'rgba(0, 0, 0, .5)',
        data: <% out.println(set); %>
    }, {
        name: 'Power Min',
        color: 'rgba(223, 83, 83, .5)',
        data: <% out.println(set2); %>
    }, {
        name: 'Power Max',
        color: 'rgba(78, 222, 83, .5)',
        data: <% out.println(set3); %>
    }, {
        name: 'Power STD DEV',
        color: 'rgba(10, 222, 222, .5)',
        data: <% out.println(set1); %>
    }]
});


		</script><br><br>


        <!-- 2nd Scatter Plot -->


        <div id="container1" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container1', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Pitch vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Power (kW)'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Pitch',
        color: 'rgba(78, 222, 83, .5)',
        data: <% out.println(set4); %>
    }]
});


        </script><br><br>


        <!-- 3rd Scatter Plot -->


        <div id="container2" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container2', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Cp vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Cp'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Cp',
        color: 'rgba(119, 122, 222, .5)',
        data: <% out.println(set5); %>
    }]
});


        </script><br><br>


        <!-- 4th Scatter Plot -->


        <div id="container3" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container3', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Grid Frequency vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Grid Frequency'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Grid Frequency',
        color: 'rgba(255, 122, 222, .5)',
        data: <% out.println(set6); %>
    }]
});


        </script><br><br>


        <!-- 5th Scatter Plot -->


        <div id="container4" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container4', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Rotor RPM vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'ROTOR RPM'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Cp',
        color: 'rgba(255, 122, 222, .5)',
        data: <% out.println(set7); %>
    }]
});


        </script><br><br>


        <!-- 6th Scatter Plot -->


        <div id="container5" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container5', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'RPM vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'RPM'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'RPM',
        color: 'rgba(60, 122, 222, .5)',
        data: <% out.println(set8); %>
    }]
});


        </script><br><br>


        <!-- 7th Scatter Plot -->


        <div id="container6" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container6', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Turbulence Intensity vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Turbulence Intensity'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Turbulence Intensity',
        color: 'rgba(60, 122, 222, .5)',
        data: <% out.println(set9); %>
    }]
});


        </script><br><br>


        <!-- 8th Scatter Plot -->


        <div id="container7" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container7', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Temperature vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Temperature'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Temperature',
        color: 'rgba(60, 122, 222, .5)',
        data: <% out.println(set10); %>
    }]
});


        </script><br><br>


        <!-- 9th Scatter Plot -->


        <div id="container8" style="min-width: 310px; height: 600px; max-width: 800px; margin: 0 auto"></div>
        <script type="text/javascript">

Highcharts.chart('container8', {
    chart: {
        type: 'scatter',
        zoomType: 'xy'
    },
    title: {
        text: 'Atmospheric Pressure vs. Windspeed'
    },
    xAxis: {
        title: {
            enabled: true,
            text: 'Windspeed (m/s)'
        },
        startOnTick: true,
        endOnTick: true,
        showLastLabel: true
    },
    yAxis: {
        title: {
            text: 'Atmospheric Pressure'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
        borderWidth: 1
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: 'rgb(100,100,100)'
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br>',
                pointFormat: '{point.x} cm, {point.y} kg'
            }
        }
    },
    series: [{
        name: 'Atmospheric Pressure',
        color: 'rgba(60, 122, 222, .5)',
        data: <% out.println(set11); %>
    }]
});


        </script><br><br>

	</body>
</html>