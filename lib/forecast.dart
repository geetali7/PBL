import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyForecast extends StatefulWidget {
  final String userLocation;
  const MyForecast({Key? key, required this.userLocation}) : super(key: key);

  @override
  _MyForecastState createState() => _MyForecastState();
}

class _MyForecastState extends State<MyForecast> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var pressure;
  var temp_max;
  var temp_min;

  Future getWeather() async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${widget.userLocation}&appid=4f36ccc2f2adf9f22438911544894ad1"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp_max = results['main']['temp_max'];
      this.temp_min = results['main']['temp_min'];
      this.pressure = results['main']['pressure'];
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width :MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child:Text(
                      "Currently",
                      style:TextStyle(
                          color: Colors.white,
                          fontSize:28.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),

                  Text(temp != null ? temp.toString()+" kelvin"+" ---Temperature" + "\u00B0" : "Loading",
                    style:TextStyle(
                        color:Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child:Text(
                      currently != null ? currently.toString() +"    -    Condition of clouds": "Loading",
                      style:TextStyle(
                          color: Colors.white,
                          fontSize:18.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ]
            ),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child:ListView(
                    children: <Widget>[
                      ListTile(
                        leading:FaIcon(FontAwesomeIcons.gauge),
                        title:Text("Pressure in milibars"),
                        trailing: Text(pressure != null ? pressure.toString() + "\u00B0" : "Loading"),
                      ),
                      ListTile(
                        leading:FaIcon(FontAwesomeIcons.thermometer),
                        title:Text("Minimum Temperature"),
                        trailing: Text(temp_min != null ? temp_min.toString() : "Loading"),
                      ),
                      ListTile(
                        leading:FaIcon(FontAwesomeIcons.thermometer),
                        title:Text("Maximum Temperature"),
                        trailing: Text(temp_max!= null ? temp_max.toString() : "Loading"),
                      ),
                      ListTile(
                        leading:FaIcon(FontAwesomeIcons.sun),
                        title:Text("Humidity in g/cm3"),
                        trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                      ),
                      ListTile(
                        leading:FaIcon(FontAwesomeIcons.wind),
                        title:Text("Wind Speed in m/s"),
                        trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),
                      ),
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}