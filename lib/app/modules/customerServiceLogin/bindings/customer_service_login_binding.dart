import 'package:get/get.dart';

import '../controllers/customer_service_login_controller.dart';

class CustomerServiceLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerServiceLoginController>(
      () => CustomerServiceLoginController(),
    );
  }
}
