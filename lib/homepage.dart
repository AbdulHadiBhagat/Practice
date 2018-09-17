import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'twoPanels.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

   AnimationController animationController;
    
  String uId = '';
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    
    this.uId = '';
    animationController = new AnimationController(vsync: this,duration: new Duration(milliseconds: 100 ),value: 1.0);
    // firebaseMessaging.configure(
    //   onLaunch: (Map<String,dynamic> msg){
    //     print('onLaunch pressed');
    //   }
    //   ,
    //   onMessage: (Map<String,dynamic> msg){
    //     print(' onMessage pressed');
    //   }
    //   ,
    //   onResume: (Map<String,dynamic> msg){
    //     print('onResume pressed');
    //   }
    //   ,
    // );

    // firebaseMessaging.requestNotificationPermissions(
    //   const IosNotificationSettings(
    //     sound: true,
    //     alert: true,
    //     badge: true

    //   )
    // );

    // firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings){
    //   print('registered');
    // });

    // firebaseMessaging.getToken().then((token){
    //   update(token);
    //       });
      
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
                  Text('   Medical Assistant',),
                  Padding(
                    child: Icon(MdiIcons.stethoscope,size: 40.0,),
                    padding: EdgeInsets.only(left: 30.0),
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
            
              
              
              
              
              FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
              String textValue = 'Hello World!';
              
              void oneTimedone() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                try{
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  if(user.isAnonymous || user == null)
                  {
                    await prefs.setInt('loadCount', 0);
                  }
                  else
                  {
                    await prefs.setInt('loadCount', 1);
                  }
                }
                catch(e){
                  await prefs.setInt('loadCount', 0);
                }
      
                //yahan notification wala kaam hr dfa new entry k upper previous py nhi hoga
                
                
              }
      
        // void update(String token) async{
        //   print(token);
        //   setState(() {
        //               textValue = token;
        //             });
        //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
        //   DatabaseReference databaseReference = new FirebaseDatabase().reference();
        //   databaseReference.child(user.uid+'/fcm-token/'+token).set({"token":token});
          
        // }
}
