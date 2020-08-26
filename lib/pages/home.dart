import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data: ModalRoute.of(context).settings.arguments;
    // print(data);
    //set Background
    String bgImage = data['isDayTime'] + '.jpg';// ? 'day.png' : 'night.png';
    // Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[500];
    Color bgColor;
    if(data['isDayTime']=='dawn')
      bgColor = Colors.orange;
    else if(data['isDayTime']=='day')
      bgColor = Colors.blue[500];
    else if(data['isDayTime']=='evening')
      bgColor = Colors.orange[700];
    else
      bgColor = Colors.indigo[800];
    // imageCache.clear();
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag'],
                        'abbr': result['abbr'],
                        'bgc': result['bgc'],
                      };
                    });
                    },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 20.0,
                        // fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                          color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/${data['flag']}'),
                        radius: 15.0,
                      ),
                    ),
//                  ClipOval(
//                    child: Image.network(
//                        'assets/${data['flag']}',
//                        fit: BoxFit.cover,
//                    ),
                  // ),
                  ],
                ),

                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Center(
                    child: Text('(${data['abbr']})',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),),
                    ),
                  ],
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
