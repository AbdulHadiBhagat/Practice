import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:medical_app/homepage.dart';


class Details extends StatefulWidget {
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  String string;

  final nameController = TextEditingController();
      final genderController = TextEditingController();
      PageController _controller = new PageController(initialPage: 0, viewportFraction: 1.0);

  String user;
  @override
  Widget build(BuildContext context) {
    return Container(
                                              height: MediaQuery.of(context).size.height,
                                              child:Material(
                                                child:page() ,
                                              ) );
                                                
                                              
  }

  Widget page(){
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/images/doctors-in-australia1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(40.0),
            child: Center(
              child: Icon(
                MdiIcons.stethoscope,
                color: Colors.redAccent,
                size: 70.0,
              ),
            ),
          ),
            getRow('Name'),
            getContainer('Abdul Hadi', false,0),
            getDivider(),
            getRow('Gender'),
            getContainer('male/female', false,1),
            getDivider(),
            getLogInButton()
		
        
         ],
      ),
    );
  }
  Widget getContainer(String hint,bool isObscure,int index){
                                          return new Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.redAccent,
                                                          width: 0.5,
                                                          style: BorderStyle.solid),
                                                    ),
                                                  ),
                                                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                                                  child: new Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      new Expanded(
                                                        child: TextField(
                                                          onChanged: (value){
                                                            string = value;
                                                          },
                                                          controller: index == 0 
                                                          ? nameController 
                                                          : genderController 
                                                          
                                                           ,
                                                          obscureText: isObscure,
                                                          textAlign: TextAlign.left,
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: '$hint',
                                                            hintStyle: TextStyle(color: Colors.grey),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        }
 
  Widget getRow(String header){
                                          
                                          return 
                                          
                                                new Row(
                                                  children: <Widget>[
                                                    new Expanded(
                                                      child: new Padding(
                                                        padding: const EdgeInsets.only(left: 40.0),
                                                        child: new Text(
                                                          "$header",
                                                          
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.redAccent,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                                
                                                
                                        
                                        }
  Widget getDivider(){
                                          return Divider(
                                                  height: 24.0,
                                                );
                                        }
  Container getLogInButton() {
    return new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
          alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: Colors.redAccent,
                  onPressed: save,
                                    child: new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: Text(
                                              "Submit",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                                  
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                    }      
  void save() async{

    http.Client client = new http.Client();
    
    FirebaseAuth.instance.currentUser().then((users){
      this.user = users.uid;
    });
    dynamic data = {
      "name" : "${nameController.text}",
      "gender" : genderController.text.toLowerCase() == "male" ? "1" : "0",
      "key" : this.user
    };

    dynamic response = postData(data);
    //String responseData = await response.stream.transform(UTF8.decoder).join(); 
    //print(responseData);
    print(data);
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );


  }

  static Future<Map> postData(Map data) async {
  dynamic url = "https://medicalassist.tk/api/register";
  http.Response res = await http.post(url, body: data); // post api call
  Map dataa = JSON.decode(res.body);
  return dataa;
}
}