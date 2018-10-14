import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/enter_details.dart';


class LoginScreen3 extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {

      final emailController = TextEditingController();
      final passController = TextEditingController();
      final cpassController = TextEditingController();
      final numController = TextEditingController();
      final dateController = TextEditingController();

       String phoneNo, smsCode, verificationId;

        //-------------Auth Work-----------------

        Future<void> verify() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      print('hello');
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed In');
      });
    };
    
    final PhoneVerificationCompleted verifiSuccess = (FirebaseUser user) {
      print('Verified');
    };

    final PhoneVerificationFailed verifiFailed = (AuthException auth) {
      print(auth.message);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiSuccess,
      verificationFailed: verifiFailed,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter Sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      print(user.uid);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() {
    FirebaseAuth.instance
        .signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    )
        .then((user) {
          print(user.uid);
       Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Details()),
  );
    }).catchError((ex) {
      print(ex);
    });
  }



        //------------------------------


      DateTime dt = DateTime.now();


      Future<Null> selectDate() async{
        final DateTime picked = await showDatePicker(
            context:context,
            initialDate: dt,
            firstDate: new DateTime(1919),
            lastDate: new DateTime(2019) 
        );

        if(picked!= null && picked != dt){
            setState(() {
                          dt = picked;
                          dateController.text = '${dt.day.toString()} , ${dt.month} , ${dt.year}';
                        });
        }
      }
  @override
  void initState() {
    super.initState();

    
  }

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/doctors-in-australia1.jpg'), ///home/developer/Documents/FlutterScreens/assets/images/doctors-in-australia1.jpg
          fit: BoxFit.cover,
        ),
      ),
      child: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 80.0),
            child: Center(
              child: Icon(
                MdiIcons.stethoscope,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Column(
                    children: <Widget>[
                      Text(
                  "Medical Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  "Your Health is our concern",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                    ],
                ),
              
                
              ],
            ),
          ),
          // new Container(
          //   width: MediaQuery.of(context).size.width,
          //   margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
          //   alignment: Alignment.center,
          //   child: new Row(
          //     children: <Widget>[
          //       new Expanded(
          //         child: new OutlineButton(
          //           shape: new RoundedRectangleBorder(
          //               borderRadius: new BorderRadius.circular(30.0)),
          //           color: Colors.redAccent,
          //           highlightedBorderColor: Colors.white,
          //           onPressed: () => gotoSignup(),
          //           child: new Container(
          //             padding: const EdgeInsets.symmetric(
          //               vertical: 20.0,
          //               horizontal: 20.0,
          //             ),
          //             child: new Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 new Expanded(
          //                   child: Text(
          //                     "SIGN UP",
          //                     textAlign: TextAlign.center,
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 100.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
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
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
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
          ),
        ],
      ),
    );
  }

  Widget LoginPage() {
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
            getForgetPassword('We Need your Number To verify your Account\nYou will be sent a text message with a code \nenter it to confirm your Account\n\n',false),
            getRow('Phone No'),
            getContainer('+92 300 9268366', false, 0),
            getDivider(),
            getLogInButton(),
            new Text('\n\n'),
            getForgetPassword('By Clicking verify you accept our Privacy Terms and \nCondition Policy.',true)
        //   new Container(
        //     width: MediaQuery.of(context).size.width,
        //     margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
        //     alignment: Alignment.center,
        //     child: Row(
        //       children: <Widget>[
        //         new Expanded(
        //           child: new Container(
        //             margin: EdgeInsets.all(8.0),
        //             decoration: BoxDecoration(border: Border.all(width: 0.25)),
        //           ),01OBJ6ePuUaNvMgKK5olaG5P6Z2
        //         ),
        //         Text(
        //           "OR CONNECT WITH",
        //           style: TextStyle(
        //             color: Colors.grey,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         new Expanded(
        //           child: new Container(
        //             margin: EdgeInsets.all(8.0),
        //             decoration: BoxDecoration(border: Border.all(width: 0.25)),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   new Container(
        //     width: MediaQuery.of(context).size.width,
        //     margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
        //     child: new Row(
        //       children: <Widget>[
        //         facebookButton(),
        //         googleButton(),
        //       ],
        //     ),
        //   )
         ],
      ),
    );
  }

  Expanded googleButton() {
    return new Expanded(
                child: new Container(
                  margin: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          color: Color(0Xffdb3236),
                          onPressed: () => {},
                          child: new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    onPressed: ()=>{},
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                    ),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          const IconData(0xea88,
                                              fontFamily: 'icomoon'),
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                        Text(
                                          "GOOGLE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }

  Expanded facebookButton() {
    return new Expanded(
                child: new Container(
                  margin: EdgeInsets.only(right: 8.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          color: Color(0Xff3B5998),
                          onPressed: () => {},
                          child: new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    onPressed: ()=>{},
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                    ),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          const IconData(0xea90,
                                              fontFamily: 'icomoon'),
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                        Text(
                                          "FACEBOOK",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  onPressed: verify,
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
                                              "Verify",
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
                  
  Row getForgetPassword(String text,bool isPrivacy) {
                      return new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding:   isPrivacy == true ? EdgeInsets.only(right: 40.0) : EdgeInsets.only(right: 20.0),
                                child: new FlatButton(
                                  padding: EdgeInsets.only(left: 0.0,right: 5.0),
                                  child: new Text(
                                    "$text",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isPrivacy == true ? Colors.black87 : Colors.redAccent,
                                      fontSize: isPrivacy == true ? 12.0 : 15.0,
                                      
                                    ),
                                    textAlign:isPrivacy == true ? TextAlign.center : TextAlign.center,
                                    
                                  ),
                                  onPressed: () => {},
                                ),
                              ),
                            ],
                          );
                    }
                  
  Widget SignupPage() {
                  
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
                                  size: 50.0,
                                ),
                              ),
                            ),
                            getRow('EMAIL'),
                            getContainer('example@mabsapps.com', false,0),
                            getDivider(),
                            getRow('PASSWORD'),
                            getContainer('**********', true,1),
                            getDivider(),
                            getRow('EMAIL'),
                            getContainer('**********', true,2),
                            getDivider(),
                            getRow('Contact No'),
                            getContainer('+92 *** *******', false,3),
                            getDivider(),
                            getRow('DATE OF BIRTH'),
                            birthContainer(),
                            getDivider(),
                            getAlreadyHaveAccount(),
                            getSignupButton(),
                          ],
                        ),
                      );
                    }
                  
  Container getSignupButton() {
                        return new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0,bottom: 20.0),
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new FlatButton(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.redAccent,
                                      onPressed: perfromSignUp,
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
                                                                  "SIGN UP",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
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
                                      
  Row getAlreadyHaveAccount() {
                                          return new Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 20.0),
                                                    child: new FlatButton(
                                                      child: new Text(
                                                        "Already have an account?",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.redAccent,
                                                          fontSize: 15.0,
                                                        ),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                      onPressed: gotoLogin,
                                                    ),
                                                  ),
                                                ],
                                              );
                                        }
                                      
  gotoLogin() {
                                          //controller_0To1.forward(from: 0.0);
                                          _controller.animateToPage(
                                            0,
                                            duration: Duration(milliseconds: 800),
                                            curve: Curves.bounceOut,
                                          );
                                        }
                                      
  gotoSignup() {
                                          //controller_minus1To0.reverse(from: 0.0);
                                          _controller.animateToPage(
                                            2,
                                            duration: Duration(milliseconds: 800),
                                            curve: Curves.bounceOut,
                                          );
                                        }
                                      
  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);
                                      
  @override
  Widget build(BuildContext context) {
                                          return Container(
                                              height: MediaQuery.of(context).size.height,
                                              child: PageView(
                                                controller: _controller,
                                                physics: new AlwaysScrollableScrollPhysics(),
                                                children: <Widget>[LoginPage(), HomePage()],
                                                scrollDirection: Axis.horizontal,
                                                
                                              ));
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
                                                            phoneNo = value;
                                                          },
                                                          controller: index == 0 
                                                          ? emailController 
                                                          : index == 1 
                                                          ? passController 
                                                          : index == 2
                                                          ? cpassController 
                                                          : numController ,
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
                                      
  void perfromSignUp() {
                                          print('Signup clicked');
                                          print('${emailController.text}  \n ${passController.text} \n ${cpassController.text} \n ${numController.text}');
                                          print(dateController.text);
                                          //Api work
                                          //Go to Some Screen
                                        }
                  
  void performLogin() {
                      print('Login Pressed');
                      print('${emailController.text} \n ${passController.text}');
                      //Api work
                      //Go to Some Screen
                    }
  Widget birthContainer(){
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
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                     // child: TextField(
                                                        //   controller: dateController ,
                                                          
                                                        //   textAlign: TextAlign.left,
                                                        //   decoration: InputDecoration(
                                                        //     border: InputBorder.none,
                                                        //     hintText: '${dt.day.toString()} , ${dt.month} , ${dt.year}',
                                                        //     hintStyle: TextStyle(color: Colors.grey),
                                                        //   ),
                                                        // ),
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      //new Expanded(
                                                        // child: TextField(
                                                        //   controller: dateController ,
                                                          
                                                        //   textAlign: TextAlign.left,
                                                        //   decoration: InputDecoration(
                                                        //     border: InputBorder.none,
                                                        //     hintText: '${dt.day.toString()} , ${dt.month} , ${dt.year}',
                                                        //     hintStyle: TextStyle(color: Colors.grey),
                                                        //   ),
                                                        // ),
                                                        
                                                        
                                                      //),
                                                      new Expanded(
                                                        child: _InputDropdown(
                                                          valueText: '${dt.day.toString()} , ${dt.month} , ${dt.year}',
                                                          onPressed: selectDate,
                                                          valueStyle: new TextStyle(
                                                            fontSize: 15.0,
                                                            
                                                          ),
                                                        ),
                                                      )
                                                      
                                                      
                                                    ],
                                                  ),
                                                );
  }
    // TODO: implement widget
  }
class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light ? Colors.redAccent : Colors.redAccent
            ),
          ],
        ),
      ),
    );
  }
}