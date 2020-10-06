import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../prayer.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var prayerData = await PrayerModel().getCityWeather("fayoum");

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home(
        location: prayerData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}