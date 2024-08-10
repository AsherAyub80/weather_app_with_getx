import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/location/location_model.dart';
import 'package:weather_app/widget/custom_text_field.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final LocationModel locationModel = Get.put(LocationModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomTextField(
              hint: 'Search Location...',
              prefixIcon: Icons.location_on,
              onChanged: (value) {
                locationModel.onSearch(value);
              },
            ),
            Expanded(
              child: Obx(() => locationModel.filteredLocationList.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) {
                        return listViewItem(index);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: locationModel.filteredLocationList.length)
                  : Center(
                      child: Text('No location found'),
                    )),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewItem(int index) {
    return ListTile(
      tileColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () {
        locationModel.onLocationSelect(index);
      },
      leading: Icon(
        Icons.location_on,
        color: Colors.white,
        size: 20,
      ),
      title: Text(
        locationModel.filteredLocationList[index],
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      ),
    );
  }
}
