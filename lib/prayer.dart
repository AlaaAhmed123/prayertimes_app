import 'package:prayerapp/networking.dart';


class PrayerModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper("http://api.aladhan.com/v1/timingsByCity?city=$cityName&country=Egypt&method=8api.aladhan.com/v1/timingsByCity?city=Fayoum&country=Egypt&method=8");

    var prayerData = await networkHelper.getData();
    return prayerData;
  }


}