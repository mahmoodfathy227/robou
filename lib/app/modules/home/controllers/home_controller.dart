import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../global/models/models.dart';

class HomeController extends GetxController {

  //Upper Drawer
  RxBool isDrawerOpen = false.obs;



  List ourOffers = [
    "اثيوبيا",
    "بوروندى",
    "سيرلانكا",
    "اوغندا",
    "الفلبين",
    "بنجلاديش",
  ];


  List ourStatistics = [
    "عملائنا",
    "زورانا",
    "خدمة العملاء",
    "عامل وعاملة",
  ];

  List OurStatisticsIcons = [
   Icons.group,
   Icons.location_on,
   Icons.headset,
   Icons.shopping_bag,

  ];
List OurStatisticsNumbers = [
    "10000",
    "22000",
    "8000",
    "12000",
];



  List OurOffersImages = [
    "https://robuashaqraa.com/uploads/our_services/jpg_%D8%B9%D9%84%D9%85-%D8%A5%D8%AB%D9%8A%D9%88%D8%A8%D9%8A%D8%A7-%D8%A3%D9%87%D9%85-%D8%A7%D9%84%D9%85%D8%B9%D9%84%D9%88%D9%85%D8%A7%D8%AA-%D9%88%D8%A7%D9%84%D8%AD%D9%82%D8%A7%D8%A6%D9%82.jpg_1732960214.jpg",
"https://robuashaqraa.com/uploads/our_services/png_Flag_of_Burundi_Flat_Round.png_1732796841.png",
    "https://robuashaqraa.com/uploads/our_services/png_Flag_of_Sri_Lanka_Flat_Round.png_1732796657.png",
    "https://robuashaqraa.com/uploads/our_services/png_Flag_of_Uganda_Flat_Round.png_1732796592.png",
    "https://robuashaqraa.com/uploads/our_services/png_Flag_of_Philippines_Flat_Round.png_1732796644.png",
    "https://robuashaqraa.com/uploads/our_services/jpeg_3.jpeg_1732607640.jpeg",

  ];

//////////////////////////////
  RxList<Datum> homeSlider = RxList<Datum>().obs();
  Rx<Data> aboutUs = Data(
    delivery: "",
  description: "",
    features: [],
    license: "",
    sectionTitle: "",
    security: "",
    service: "",
    title: "",
  ).obs;
Rx<Services> services = Services(
  data: [],
).obs; // <Services>

  Rx<CustomerService> customerServices = CustomerService(data: []).obs;
  Rx<Countries> countries = Countries(data: []).obs;
  Rx<Statictics> statictics = Statictics(data: []).obs;
  Rx<Steps> steps = Steps(data: StepsInnerData(
      title: "", recruitmentStepDesc: "",
      recruitmentStep1Desc: "",
      image1: "",
      image2: "",
      image3: "",
      recruitmentStep2Desc: "",
      recruitmentStep3Desc: "",
      recruitmentStep4Desc: "",
      recruitmentStep5Desc: "")).obs;



  Rx<Settings> settings = Settings(
    data: SettingsData
      (
        tapLogo: "",
        headerLogo: "",
        footerLogo: "",
        title: "",
        footerDesc: "", phone1: "",
        phone2: "",
        phone3: "",
        phone4: "",
        phone5: "",
        phone6: "",
        phone7: "",
        address1: "",
        address2: "",
        lat: 0,
        long: 0,
        email: "",
        email2: "",
        facebook: "",
        linkedIn: "",
        twitter: "",
        instagram: "",
        whatsApp:"",
        snapchat: "",
        telegram: "",
        youtube: "",
        gmail: "",
        termsPageLink: "",
        privacyPageLink: "",
        headerTitle: "",
        headerDesc: "",
        aboutUs: "",
        delivery: "",
        security: "",
        license: "",
        service: "",
        mainColor: "", )
  ).obs;
///////////////////////////////
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchHomeData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  launchWhatsApp(phone) async {
    String url = "https://wa.me/+966$phone?text=مرحبا";
    await launchUrl(Uri.parse(url));
  }

  launchCall(phone) async {
    String url = "tel://+966$phone";
    await  launchUrl(Uri.parse(url));
  }

  launchMyUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }



  Future<dynamic> fetchHomeData() async {
    return await Future.wait([
      getHomeSliders(),
      getAboutUs(),
      getServices(),
      getCustomerService(),
      getCountries(),
      getStatistics(),
      getSteps(),
      getSettings(),

    ]);
  }
////////////////////////Home Sliders/////////////////////////
  RxBool isHomeSliderLoading = false.obs;
Future<dynamic> getHomeSliders() async {
  isHomeSliderLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/sliders');
      if (response.statusCode == 200) {
        for(var slider in response.data['data']){
          homeSlider.add(Datum.fromJson(slider));
        }

        print("success getting home sliders ${homeSlider.value}");
        isHomeSliderLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
print("error getting home sliders $e");
isHomeSliderLoading.value = false;
return e;
    }

}
/////////////////////////////////////////////////////////////


////////////////////////About Us /////////////////////////
  RxBool isAboutUsLoading = false.obs;
  Future<dynamic> getAboutUs() async {
    isAboutUsLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/about_us');
      if (response.statusCode == 200) {
        aboutUs.value = Data.fromJson(response.data['data']);


        print("success getting about us ${aboutUs.value}");
        isAboutUsLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
      print("error getting about us $e");
      isAboutUsLoading.value = false;
      return e;
    }

  }
/////////////////////////////////////////////////////////////

//////////////////////// Services /////////////////////////
  RxBool isServicesLoading = false.obs;
  Future<dynamic> getServices() async {
    isServicesLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/services');
      if (response.statusCode == 200) {
        print("the run time ${response.data['data'].runtimeType}");
        print("the run time 2 ${services.value.runtimeType}");

        services.value = Services.fromJson(response.data);


        print("success getting services ${services.value}");
        isServicesLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
      print("error getting services $e");
      isServicesLoading.value = false;
      return e;
    }

  }
/////////////////////////////////////////////////////////////

 /////////////////////////// Customer Services ///////////////////////
  RxBool isCustomerServiceLoading = false.obs;
  Future<dynamic> getCustomerService() async {
    isCustomerServiceLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/customer_services');
      if (response.statusCode == 200) {
        print("the run time ${response.data['data'].runtimeType}");
        print("the run time 2 ${services.value.runtimeType}");

        customerServices.value = CustomerService.fromJson(response.data);


        print("success getting services ${customerServices.value}");
        isCustomerServiceLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
      print("error getting services $e");
      isCustomerServiceLoading.value = false;
      return e;
    }

  }

/////////////////////////////////////////////////////////////


/////////////////////////// Countries ///////////////////////
  RxBool isCountriesLoading = false.obs;
  Future<dynamic> getCountries() async {
    isCountriesLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/get_countries');
      if (response.statusCode == 200) {
        print("the run time ${response.data['data'].runtimeType}");
        print("the run time 2 ${countries.value.runtimeType}");

        countries.value = Countries.fromJson(response.data);


        print("success getting countries ${countries.value}");
        isCountriesLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
      print("error getting countries $e");
      isCountriesLoading.value = false;
      return e;
    }

  }

/////////////////////////////////////////////////////////////


/////////////////////////// Statistics ///////////////////////
  RxBool isStatisticsLoading = false.obs;
  Future<dynamic> getStatistics() async {
    isStatisticsLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/get_statictics');
      if (response.statusCode == 200) {


        statictics.value = Statictics.fromJson(response.data);


        print("success getting statictics ${statictics.value}");
        isStatisticsLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
      print("error getting statictics $e");
      isStatisticsLoading.value = false;
      return e;
    }

  }

/////////////////////////////////////////////////////////////

/////////////////////////// Steps ///////////////////////
  RxBool isStepsLoading = false.obs;
  Future<dynamic> getSteps() async {
    isStepsLoading.value = true;
    try{
      final response = await apiService.getRequest('/home/get_recruitment_steps');
      if (response.statusCode == 200) {


        steps.value = Steps.fromJson(response.data);


        print("success getting steps ${steps.value}");
        isStepsLoading.value = false;
        return response.data['data'];
      }

    }catch(e){
      print("error getting steps $e");
      isStepsLoading.value = false;
      return e;
    }

  }

/////////////////////////////////////////////////////////////

/////////////////////////// Settings ///////////////////////
  RxBool isSettingsLoading = false.obs;
  Future<dynamic> getSettings() async {
    isSettingsLoading.value = true;
    try{
      final response = await apiService.getRequest('/settings/');
      if (response.statusCode == 200) {


        settings.value = Settings.fromJson(response.data);


        print("success getting settings ${settings.value}");
        isSettingsLoading.value = false;
       AppColors.secondaryColor = hexToColor(settings.value.data!.mainColor!);
        print("setting color ${AppColors.secondaryColor}");
        return response.data['data'];
      }

    }catch(e){
      print("error getting settings $e");
      isSettingsLoading.value = false;
      return e;
    }

  }
  // Method to convert hex string to Color object
  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
/////////////////////////////////////////////////////////////

