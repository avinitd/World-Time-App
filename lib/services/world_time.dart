import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {

  String location; // location name for the UI
  String time; // the time in that location
  String flag; // URL to an asset flag icon
  String url; // location URL for API endpoint
  bool isDayTime; // true or false
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    //make the request
    try {
        Response response = await get(
            'http://worldtimeapi.org/api/timezone/$url');
        Map data = jsonDecode(response.body);
        print(data);

        // get properties from data
        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(0, 3);
        String offset2 = data['utc_offset'].substring(4, 6);
        print(offset);
        print(offset2);
        if(offset[0]=='-')
          offset2 = '-' + offset2;
        // create a DateTime object
        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(offset2)));

        // set the time property
        isDayTime = now.hour >= 6 && now.hour < 18 ? true: false;
        time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('Caught Error: $e');
      time = 'Could not get time data';
    }

  }
}