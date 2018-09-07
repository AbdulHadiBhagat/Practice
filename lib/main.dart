import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

import 'login_screen_3.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Login Screen 1',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/homepage' : (BuildContext context)=> HomePage(),
       
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];
  String times = '';
  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      checkTimes();
      
          }
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: this.times == '' ? HomePage():LoginScreen3()
            ),
          );
        }
      
        void checkTimes() async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int times = prefs.getInt('loadCount');
          if(times == null || times == 0){
            setState(() {
                          this.times = 'done';
                        });
          }else
          {
            setState(() {
                          this.times = '';
                        });
          }

        }
}