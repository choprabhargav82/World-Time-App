import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time = "";
  String flag;
  String url;
  bool isDaytime = false;

  WorldTime({
    required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    await Future.delayed(Duration(seconds: 3), () {});

    try{
      //Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time
      isDaytime = now.hour > 4 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch(e) {
      print(e);
      time = 'Could not get time!';
    }
  }
}

