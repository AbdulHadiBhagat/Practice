import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'twoPanels.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

   AnimationController animationController;

  String uId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.uId = '';
    animationController = new AnimationController(vsync: this,duration: new Duration(milliseconds: 100 ),value: 1.0);
    oneTimedone();
        }

        @override
          void dispose() {
            // TODO: implement dispose
            super.dispose();
            animationController.dispose();
          }

          bool get isPanelVisible{
        final AnimationStatus status = animationController.status;
        return status == AnimationStatus.completed || status == AnimationStatus.forward;
      }
      
        @override
        Widget build(BuildContext context) {
          return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Row(
          children: <Widget>[
            Text('Medical Assistant',),
            Padding(
              child: Icon(Icons.home,size: 40.0,),
              padding: EdgeInsets.only(left: 50.0),
            )
            
          ],
        ),
        leading: new IconButton(
          onPressed: (){
            animationController.fling(velocity: isPanelVisible?-1.0:1.0);
          },
          icon: new AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: animationController.view,
          ),
        ),
      ),
      body: new TwoPanels(animationController),
    );
        }
      
        
        
        
        
        
        
        
        void oneTimedone() async {

          SharedPreferences prefs = await SharedPreferences.getInstance();
          
          await prefs.setInt('loadCount', 1);
        }
}
