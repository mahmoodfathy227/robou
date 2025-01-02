import 'package:get/get.dart';

import '../controllers/our_countries_controller.dart';

class OurCountriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OurCountriesController>(
      () => OurCountriesController(),
    );
  }
}
