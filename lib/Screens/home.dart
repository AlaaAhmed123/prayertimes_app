import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayerapp/Screens/city_screen.dart';
import 'package:prayerapp/prayer.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  Home({this.location});

  final location;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  PrayerModel prayerModel = PrayerModel();
  String faj;
  String du;
  String as;
  String ma;
  String ash;
  String date;
  String name;
  String sunrise;
  String sunset;

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('kk:mm');
  final String formatted = formatter.format(now);
  String _check;

  @override
  void initState() {
    super.initState();

    print(widget.location);
    updateUI(widget.location);
    getName();
  }

  void updateUI(dynamic prayerData) {
    setState(() {
      if (prayerData == null) {
        return;
      }
      faj = prayerData["data"]["timings"]["Fajr"];
      du = prayerData["data"]["timings"]["Dhuhr"];
      as = prayerData["data"]["timings"]["Asr"];
      ma = prayerData["data"]["timings"]["Maghrib"];
      ash = prayerData["data"]["timings"]["Isha"];
      date = prayerData["data"]["date"]["readable"];
      name = prayerData["data"]["meta"]["timezone"];
      sunrise = prayerData["data"]["timings"]["Sunrise"];
      sunset = prayerData["data"]["timings"]["Sunset"];
    });
  }

  void getName() {
    if (int.parse(formatted.substring(0, 2)) <=
        int.parse(faj.substring(0, 2))||int.parse(formatted.substring(0, 2)) >
        int.parse(ash.substring(0, 2))) {
      setState(() {
        _check = "Fajr";
      });
    } else if (int.parse(formatted.substring(0, 2)) <=
        int.parse(du.substring(0, 2))) {
      setState(() {
        _check = "Dhuhr";
      });
    } else if (int.parse(formatted.substring(0, 2)) <=
        int.parse(as.substring(0, 2))) {
      setState(() {
        _check = "Asr";
      });
    } else if (int.parse(formatted.substring(0, 2)) <=
        int.parse(ma.substring(0, 2))) {
      setState(() {
        _check = "Maghrib";
      });
    } else if (int.parse(formatted.substring(0, 2)) <=
        int.parse(ash.substring(0, 2))) {
      setState(() {
        _check = "Isha";
      });
    }


    print(_check);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prayer times'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/welcome.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            var data =
                            await prayerModel.getCityWeather("cairo");
                            updateUI(data);
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        Text(
                          name.split("/")[1],
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        FlatButton(
                          child: Icon(Icons.location_city,size: 50.0,),
                          onPressed: () async {
                            var typedName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CityScreen();
                                },
                              ),
                            );
                            if (typedName != null) {
                              var data =
                              await prayerModel.getCityWeather(typedName);
                              updateUI(data);
                            }
                          },
                        ),
                      ]),
                ),
              ), //Name of City
              Center(
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                  size: 25.0,
                ),
              ), //Icon
              Center(
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ), //Date
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 5, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color:
                            Colors.black, //                   <--- border color
                        width: 2.0,
                      )),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sunrise",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            sunrise,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color:
                            Colors.black, //                   <--- border color
                        width: 2.0,
                      )),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sunset",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            sunset,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ), //sun
              Container(
                decoration: _check == "Fajr"
                    ? BoxDecoration(
                        border: Border.all(
                        color:
                            Colors.red, //                   <--- border color
                        width: 5.0,
                      ))
                    : null,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Fajr:",
                        style: kTempTextStyle,
                      ),
                      Text(
                        faj,
                        style: kMessageTextStyle,
                      ),
                    ],
                  ),
                ),
              ), //fajr
              Container(
                  decoration: _check == "Dhuhr"
                      ? BoxDecoration(
                          border: Border.all(
                          color:
                              Colors.red, //                   <--- border color
                          width: 5.0,
                        ))
                      : null,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Dhuhr:",
                          style: kTempTextStyle,
                        ),
                        Text(
                          du,
                          style: kMessageTextStyle,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  )), //Dhuhr
              Container(
                  decoration: _check == "Asr"
                      ? BoxDecoration(
                          border: Border.all(
                          color:
                              Colors.red, //                   <--- border color
                          width: 5.0,
                        ))
                      : null,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Asr:",
                          style: kTempTextStyle,
                        ),
                        Text(
                          as,
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  )), //Asr
              Container(
                  decoration: _check == "Maghrib"
                      ? BoxDecoration(
                          border: Border.all(
                          color:
                              Colors.red, //                   <--- border color
                          width: 5.0,
                        ))
                      : null,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Maghrib:",
                          style: kTempTextStyle,
                        ),
                        Text(
                          ma,
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  )), //Maghrib
              Container(
                  decoration: _check == "Isha"
                      ? BoxDecoration(
                          border: Border.all(
                          color:
                              Colors.red, //                   <--- border color
                          width: 5.0,
                        ))
                      : null,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Isha:",
                          style: kTempTextStyle,
                        ),
                        Text(
                          ash,
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  )), //Isha
            ],
          ),
        ),
      ),
    );
  }
}
