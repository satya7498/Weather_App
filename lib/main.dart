import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: MyWeather(

      ),
    );
  }
}
 class MyWeather extends StatefulWidget {
   @override
   _MyWeatherState createState() => _MyWeatherState();
 }

 class _MyWeatherState extends State<MyWeather> {

   var temp;
   var des;
   var currently;
   var humidity;
   var windSpeed;

   Future getWeather()  async{


     http.Response response= await http.get("http://api.openweathermap.org/data/2.5/weather?q=Boston&appid=a6b5fd3dbb5b8393c34a6a9d4127437f");
     var result=jsonDecode(response.body);

     setState((){
       this.temp=result['main']['temp'];
       this.des=result['weather'][0]['description'];
       this.currently=result['weather'][0]['main'];
       this.humidity=result['main']['humidity'];
       this.windSpeed=result['wind']['speed'];
     });}

     @override
     void initState(){
       super.initState();
       this.getWeather();

   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body:Column(

         children: [
           Container(

             height: MediaQuery.of(context).size.height/2,
             width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
             color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60.0),

                  bottomLeft: Radius.circular(60.0)),
              ),
               child: Column(
               mainAxisAlignment:MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Padding(

                     padding: EdgeInsets.fromLTRB(0, 60, 0, 10.0),
                     child: Text("Boston Current Weather",style: TextStyle(fontSize: 19,color: Colors.white,fontWeight: FontWeight.w600),),
                   ),
                 Padding(

                   padding: EdgeInsets.fromLTRB(13, 20, 0, 10.0),
                   child: Text(temp!=null?temp.toString()+"\u00B0":"Loading",style:
                   TextStyle(fontSize: 50,fontWeight: FontWeight.w600,color:Colors.white),),
                 ),

                 Padding(

                   padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                   child:Text(des!= null ? des.toString():"Loading",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),),
                 ),
               ],
             ),
           ),

           Expanded(
               child:
               Padding(
                 padding: EdgeInsets.all(20),
                 child: ListView(
                   children: [
                     ListTile(leading: FaIcon(FontAwesomeIcons.thermometerHalf,color: Colors.deepPurpleAccent,size: 30,)
                              ,title:Text("Temperature"),
                               trailing: Text(temp!=null?temp.toString()+"\u00B0":"Loading"),),

                     ListTile(leading: FaIcon(FontAwesomeIcons.cloud,color: Colors.deepPurpleAccent,size: 30,)
                       ,title:Text("Weather"),
                       trailing: Text(currently!=null?currently.toString():"Loading"),),

                     ListTile(leading: FaIcon(FontAwesomeIcons.sun,color: Colors.deepPurpleAccent,size: 30,)
                       ,title:Text("Humidity"),
                       trailing: Text(humidity!=null?humidity.toString():"Loading"),),

                     ListTile(leading: FaIcon(FontAwesomeIcons.wind,color: Colors.deepPurpleAccent,size: 30,)
                       ,title:Text("Wind Speed"),
                       trailing: Text(windSpeed!=null?windSpeed.toString():"Loading"),),
                   ],
                 ),
           )
             
           ),
         ],
       ),
     );
   }
 }

