import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  late String location; //location name for the ui
  late String time; //time of that location
  late String flag; //url to an asset flag icon
  late String url; //location url for api endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{

      // make the request

      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1,3);


      // print(datetime);
      // create datetime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour >= 6 && now.hour < 20? true : false;
      // set the time property
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('caught error: $e');
      time='could not get time data';
    }




  }

}