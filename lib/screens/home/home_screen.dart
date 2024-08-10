import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/helper/theme_helper.dart';
import 'package:weather_app/screens/home/home_model.dart';
import 'package:weather_app/widget/loader_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeModel = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    iconAndTemperature(),
                  ],
                ),
              ),
              const LoaderView(),
            ],
          ),
        ));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ThemeHelper.primaryColor,
      title: Obx(
        () => Text(
          homeModel.location.value,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leading: Container(),
      actions: [
        IconButton(
          onPressed: () {
            homeModel.changeLocation();
          },
          icon: const Icon(
            Icons.location_on_outlined,
          ),
        )
      ],
    );
  }

  Widget iconAndTemperature() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0x00EDE1E1),
          Colors.white24,
        ], stops: [
          0.01,
          0.89
        ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => homeModel.weatherModel.value.weather?.first.icon == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : weatherImage()),
            const SizedBox(height: 10),
            Text(
              homeModel.getCurrentDate(),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Obx(
                  () => Text(
                    (homeModel.weatherModel.value.main?.temp ?? 00)
                        .toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Text(
                  ' o',
                  style: TextStyle(
                      color: Colors.white,
                      fontFeatures: [FontFeature.superscripts()]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                homeModel.weatherModel.value.weather?.first.main ?? 'N/A',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            divider(),
            Obx(() => weatherValue()),
            divider(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget weatherImage() {
    String imgUrl =
        "https://openweathermap.org/img/wn/${homeModel.weatherModel.value.weather?.first.icon}@4x.png";
    debugPrint("image: $imgUrl");
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: 120,
      width: 120,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          // child: Image.asset('images/clouds.png'),
          child: Icon(Icons.warning),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget divider() {
    return Divider(
      height: 28,
      color: Colors.white.withOpacity(0.5),
    );
  }

  Widget weatherValue() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: detailItem(
                title: 'Minimum',
                value:
                    " ${homeModel.weatherModel.value.main?.tempMin ?? 'N/A'}",
                icon: CupertinoIcons.down_arrow,
                unit: '',
              ),
            ),
            Expanded(
              child: detailItem(
                title: 'Maximum',
                value: "${homeModel.weatherModel.value.main?.tempMax ?? 'N/A'}",
                icon: CupertinoIcons.up_arrow,
                unit: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: detailItem(
                title: 'Wind',
                value: "${homeModel.weatherModel.value.wind?.speed ?? 'N/A'}",
                icon: Icons.air,
                unit: 'm/s',
              ),
            ),
            Expanded(
              child: detailItem(
                title: 'Feel Like',
                value:
                    '${homeModel.weatherModel.value.main?.feelsLike ?? 'N/A'}',
                icon: Icons.cloudy_snowing,
                unit: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: detailItem(
                title: 'Pressure',
                value:
                    '${homeModel.weatherModel.value.main?.pressure ?? 'N/A'}',
                icon: Icons.thermostat,
                unit: 'mbar',
              ),
            ),
            Expanded(
              child: detailItem(
                title: 'Humidity',
                value:
                    '${homeModel.weatherModel.value.main?.humidity ?? 'N/A'}',
                icon: Icons.water_drop_outlined,
                unit: '%',
              ),
            ),
          ],
        ),
        divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: detailItem(
                title: 'Sun Rise',
                value:
                    '${homeModel.covertTimeStampToTime(homeModel.weatherModel.value.sys?.sunrise)}',
                icon: Icons.sunny,
                unit: '',
              ),
            ),
            Expanded(
              child: detailItem(
                title: 'Sun Set',
                value:
                    '${homeModel.covertTimeStampToTime(homeModel.weatherModel.value.sys?.sunset)}',
                icon: Icons.sunny_snowing,
                unit: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: detailItem(
                title: 'Latitude',
                value: '${homeModel.weatherModel.value.coord?.lat ?? 'N/A'}',
                icon: Icons.location_on,
                unit: '',
              ),
            ),
            Expanded(
              child: detailItem(
                title: 'Longitude',
                value: '${homeModel.weatherModel.value.coord?.lon ?? 'N/A'}',
                icon: Icons.location_on,
                unit: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: detailItem(
                title: 'Cloud cover',
                value: '${homeModel.weatherModel.value.clouds?.all ?? 'N/A'}',
                icon: Icons.cloud,
                unit: '%',
              ),
            ),
            Expanded(
              child: detailItem(
                title: 'Visibility',
                value: ((homeModel.weatherModel.value.visibility ?? 0) *
                        0.000621371)
                    .toStringAsFixed(2),
                icon: Icons.visibility_outlined,
                unit: 'mi',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget detailItem(
      {required String title,
      required String value,
      required IconData icon,
      required String unit}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.17)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value != 'N/A' ? '$value $unit' : '$value',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 12, fontFamily: 'Poppins'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
