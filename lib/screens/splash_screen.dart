import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        Duration(
          seconds: 2,
        ), () {
      Get.to(() => HomeScreen());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3C6FD1),
              Color(0xFF7CA9FF),
            ],
            stops: [0.25, 0.87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation.json'),
            SizedBox(
              height: 10,
            ),
            Text(
              ' Weather Whize',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              ' Weather Forecast',
              style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
