import 'package:get/get.dart';

import '../modules/contactUs/bindings/contact_us_binding.dart';
import '../modules/contactUs/views/contact_us_view.dart';
import '../modules/customerServiceLogin/bindings/customer_service_login_binding.dart';
import '../modules/customerServiceLogin/views/customer_service_login_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/ourCountries/bindings/our_countries_binding.dart';
import '../modules/ourCountries/views/our_countries_view.dart';
import '../modules/ourServices/bindings/our_services_binding.dart';
import '../modules/ourServices/views/our_services_view.dart';
import '../modules/requests/bindings/requests_binding.dart';
import '../modules/requests/views/requests_view.dart';
import '../modules/trackOrder/bindings/track_order_binding.dart';
import '../modules/trackOrder/views/track_order_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.OUR_SERVICES,
      page: () => const OurServicesView(),
      binding: OurServicesBinding(),
    ),
    GetPage(
      name: _Paths.OUR_COUNTRIES,
      page: () => const OurCountriesView(),
      binding: OurCountriesBinding(),
    ),
    GetPage(
      name: _Paths.TRACK_ORDER,
      page: () => const TrackOrderView(),
      binding: TrackOrderBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.REQUESTS,
      page: () => RequestsView(
        title: 'استقدام',
      ),
      binding: RequestsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_SERVICE_LOGIN,
      page: () => const CustomerServiceLoginView(),
      binding: CustomerServiceLoginBinding(),
    ),
  ];
}
