import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Abdul Shakoor',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: new Info());
  }
}

class Info extends StatefulWidget {
  @override
  createState() => new InfoState();
}

class InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
      body: content(),
    );
  }

  Widget content() {
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Doctor Name :',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Dr. Amin Kharadi',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                new SizedBox(height: 20.0,),
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Phone No :',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  '+92 300 9268366',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          new FavoriteWidget()
        ],
      ),
    );

    Widget imageSection = new Image.asset(
      'images/patient.jpg',
      width: 600.0,
      height: 240.0,
      fit: BoxFit.cover,
    );

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'APPOINTMENT'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        'Patients Health Status given by the doctor with some guidleines to follow provide by the doctor.',
        softWrap: true,
      ),
    );

    return new Scaffold(
        body: new Container(child: new ListView(children: [imageSection, titleSection, buttonSection, textSection,
         new Container(
                  padding: const EdgeInsets.only(bottom: 8.0,left: 30.0),
                  child: new Text(
                    'Do\'s :',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Padding(child: 
                new Text(
                  'Drink more Water\nEat before each pill',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),padding: EdgeInsets.only(left: 30.0),
                ),
                 new Container(
                  padding: const EdgeInsets.only(bottom: 8.0,left: 30.0,top: 20.0),
                  child: new Text(
                    'Dont\'s :',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                new Padding(
                child:new Text(
                  'Dont drink softfrinks until 25/9/2019',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                padding: EdgeInsets.only(left: 30.0),),
                new SizedBox(height: 30.0,)
                ])));
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  createState() => new FavoriteWidgetState();
}

class FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favoriteCount -= 1;
        _isFavorite = false;
      } else {
        _favoriteCount += 1;
        _isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
              icon: (_isFavorite ? new Icon(Icons.star) : new Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleFavorite),
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
            child: new Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }
}
