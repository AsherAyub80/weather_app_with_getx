import 'package:get/get.dart';

class LocationModel extends GetxController {
  List<String> filteredLocationList = <String>[].obs;
  List<String> allLocationList = [
    'Karachi, Pakistan',
    'Rawalpindi, Pakistan',
    'Lahore, Pakistan',
    'Hyderabad, Pakistan',
    'Multan, Pakistan',
    'Islamabad, Pakistan',
    'Faisalabad, Pakistan',
    'Quetta, Pakistan',
    'Peshawar, Pakistan',
    'Shahdadpur, Pakistan',
    'New York, United States',
    'Dubai, United Arab Emirates',
  ];

  @override
  void onReady() {
    filteredLocationList.addAll(allLocationList);
    super.onReady();
  }

  onSearch(String value) {
    filteredLocationList.clear();
    filteredLocationList.addAll(allLocationList.where(
        (element) => element.toLowerCase().contains(value.toLowerCase())));
  }

  onLocationSelect(int index) {
    Get.back(result: filteredLocationList[index]);
  }
}
