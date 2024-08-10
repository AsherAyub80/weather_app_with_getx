import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/helper/global_variable.dart';
import 'package:weather_app/screens/home/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/location/location_screen.dart';

class HomeController extends GetxController {
  Rx<WeatherModel> weatherModel = WeatherModel().obs;
  RxString location = 'Karachi, Pakistan'.obs;

  @override
  void onReady() {
    getLastLocationAndUpdate();
    super.onReady();
  }

  void changeLocation() async {
    var result = await Get.to(LocationScreen());

    if (result != null) {
      location.value = result;
      GetStorage().write('lastLocation', location.value);
      getLastLocationAndUpdate();
    }
  }

  getLastLocationAndUpdate() {
    //get last selected locaton

    location.value = GetStorage().read('lastLocation') ?? 'Karachi, Pakistan';

    //get local data
    var data = GetStorage().read(location.value) ?? <String, dynamic>{};
    weatherModel.value = WeatherModel.fromJson(data);

    //get latest data
    getWeatherUpdate();
  }

  getWeatherUpdate() async {
    try {
      //header
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      //Url

      String url = 'https://api.openweathermap.org/data/2.5/weather';

      Map<String, String> params = {
        'appid': '005352711eb576ca5172c739f080d539',
        'q': location.value,
        'units': 'metric',
      };

      Uri uriValue = Uri.parse(url).replace(queryParameters: params);
      GlobalVariable.showLoader.value = true;

      http.Response response = await http.get(uriValue, headers: header);

      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      GlobalVariable.showLoader.value = false;

      if (parsedJson['cod'] == 200) {
        //store data locally
        GetStorage().write(location.value, parsedJson);
        weatherModel.value = WeatherModel.fromJson(parsedJson);
        Get.snackbar(
          'Success',
          'Weather Updated Successfully',
        );
        update();
      } else {
        Get.snackbar(
          'failed',
          'Something went wrong',
          forwardAnimationCurve: Curves.bounceIn,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  String covertTimeStampToTime(int? timeStamp) {
    String time = 'N/A';
    if (timeStamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      time = DateFormat('hh:mm a').format(dateTime);
    }
    return time;
  }

  String getCurrentDate() {
    String date = '';
    DateTime dateTime = DateTime.now();
    date = DateFormat("EEE | MMM dd").format(dateTime);
    return date;
  }
}
