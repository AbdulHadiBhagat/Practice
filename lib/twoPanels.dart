import 'package:flutter/material.dart';
import 'detail_info.dart';
import 'cards screen.dart';
class MenuItem{
    MenuItem(this.title,this.child);
    String title;
    Widget child;
    @override
      String toString() {
        // TODO: implement toString
        return '$runtimeType("$title")';
      }
}





class TwoPanels extends StatefulWidget {

  final AnimationController animationController;

  TwoPanels(this.animationController);
  
  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {

  List<MenuItem> items = [
    new MenuItem('Profile', 
    new Container(
      child: new DetailInfo() ,
    )
    ),
    new MenuItem('Home', new Container(
      child: new CardsDemo(),
    ))
  ];
  
  int selected = 1;
  

  Animation<RelativeRect> animation(BoxConstraints box){
    final height = box.biggest.height;
    final backPanelHeight = height - headerHeight;
    final frntPanelHeight = -headerHeight;

    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frntPanelHeight),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
    ).animate(new CurvedAnimation(parent: widget.animationController,curve: Curves.linear));
  }

  static const headerHeight = 32.0;
  Widget panels(BuildContext context,BoxConstraints constraints){

    final ThemeData = Theme.of(context);

    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Center(
              child: new ListView(
                children: <Widget>[
                   new Material(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        ),
        color: 
          items[selected].title == 'Profile' ? Colors.white.withOpacity(0.25) : Colors.transparent,
          
        child: new ListTile(
          title: new Text('Profile',style:new TextStyle(color: Colors.white,fontSize: 20.0)),
          selected : items[selected].title == 'Profile' ? true : false,
          onTap: () {
            setState(() {
                          selected=0;
                        });
          },
        ),
      ),
                 new Material(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        ),
        color: 
          items[selected].title == 'Home' ? Colors.white.withOpacity(0.25) : Colors.transparent,
          
        child: new ListTile(
          title: new Text('Home',style:new TextStyle(color: Colors.white,fontSize: 20.0)),
          selected : items[selected].title == 'Home' ? true : false,
          onTap: () {
            setState(() {
                          selected = 1;
                        });
          },
        ),
      )
                ],
              ),
            ),            
          ),
          new PositionedTransition(

            rect: animation(constraints),

            child :new Material(
            elevation: 12.0,
            borderRadius: BorderRadius.only(
              topLeft: new Radius.circular(16.0),
              topRight: new Radius.circular(16.0),
              
            ),
            child: new Column(
              children: <Widget>[
                new Container(
                  height: headerHeight,
                  child: Center(
                    child: new Text(items[selected].title,style:new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold))

                  ),
                ),
                new Expanded(
                  child: new Center(
                    child: items[selected].child,
                  ),
                )
              ],
            ),
          ),),
        ],
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: panels,
    );
  }
}