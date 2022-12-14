import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    // background
    String bgImage = data['isDaytime']? 'Minimalist_day_hd.png' : 'Minimalist_night_hd.png';

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: FlatButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data ={
                            'location': result['location'],
                            'time' : result['time'],
                            'flag' : result['flag'],
                            'isDaytime' : result['isDaytime'],
                          };
                        });
                      },
                      icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                      label: Text(
                        'Edit Location',
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),


                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.grey[300],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(data['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.grey[300],
                ),
                ),
              ],
            )),
      ),
    );
  }
}
