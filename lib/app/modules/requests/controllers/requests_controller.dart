import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/data/services/notification_service.dart';
import 'package:robua/app/modules/global/models/models.dart';
import 'package:robua/app/modules/home/views/home_view.dart';
import 'package:robua/app/modules/requests/views/success_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';

class RequestsController extends GetxController {
  Rx<Cv> cv = Cv(cvs: [],
      jobs: [],
      experience: [],
      religion: [],
      currentPage: null,
      lastPage: null,
      nationalities: []).obs;
  RxBool isExpanded = false.obs;
  final count = 0.obs;
  RxString type = ''.obs;
  RxString experience = ''.obs;
  RxString job = ''.obs;
  RxString religion = ''.obs;
  RxString nationality = ''.obs;
  RxString ageTo = ''.obs;
  RxString ageFrom = ''.obs;
///////////////////////////////////
  RxInt cvId = 0.obs;
  Rx<TextEditingController> nameValue = TextEditingController().obs;
  Rx<TextEditingController> phoneValue = TextEditingController().obs;
  RxString selectedCustomerServiceName = ''.obs;
  RxString selectedCustomerServiceId = "".obs;
  RxString selectedCustomerServiceWhats = ''.obs;
  RxString selectedCustomerServicePhone = ''.obs;
RxString lat = ''.obs;
RxString long = ''.obs;
  RxString rentStartDate = ''.obs;
  RxString rentEndDate = ''.obs;

  List<String> ageFromList = [
    '10',
    '20',
    '30',
    '40',
    '50',

  ];

  List<String> ageToList = [
    '10',
    '20',
    '30',
    '40',
    '50',

  ];

RxString orderTrackNo = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    clearFilter();
  }


  void increment() => count.value++;

  RxBool isCvLoading = false.obs;




  getCvs() async {
    isCvLoading.value = true;
    print('get cvs');
    print(type.value);
    print(experience.value);
    print(job.value);
    print(religion.value);
    print(nationality.value);
    try {
      String? experienceValue;
      int? religionValue;
      int? jobValue;
      int? nationalityValue;

      if (experience.value.isNotEmpty) {
        experienceValue =
        experience.value == "ليس لدية خبرة" ? 'new' : 'with_experience';
      }
      if (religion.value.isNotEmpty) {
        religionValue = religion.value == 'مسلم' ? 1 : 0;
      }
      if (job.value.isNotEmpty) {
        jobValue = cv.value.jobs
            .firstWhere((e) => e.title == job.value)
            .id;
      }

      if (nationality.value.isNotEmpty) {
        nationalityValue = cv.value.nationalities
            .firstWhereOrNull((myNationality) => myNationality.title == nationality.value)
            ?.id;
        print("result end nationality is ${nationalityValue}");
      }


      final response = await apiService.getRequest('/cvs',
          queryParameters: {
            'type': type ,
            'experience': experience.value.isNotEmpty ? experienceValue : '',
            'job': job.value.isNotEmpty ? jobValue : '',
            'religion': religion.value.isNotEmpty ? religionValue : '',
            'nationality': nationality.value.isNotEmpty ? nationalityValue : '',
            'age_to': ageTo.value.isNotEmpty ?  ageTo.value : '',
            'age_from': ageFrom.value.isNotEmpty ? ageFrom.value : '',
          }

      );
      if (response.statusCode == 200) {
        cv.value = Cv.fromJson(response.data);
        print(cv.value.cvs.length);
        print("sent nationality is ${nationality.value} + ${nationalityValue}");
        print(response.data.toString());
        isCvLoading.value = false;
        return response.data;
      }
    } catch (e) {
      print("error getting cvs" + e.toString());
      isCvLoading.value = false;
    }
  }

  clearFilter() {
    experience.value = '';
    job.value = '';
    religion.value = '';
    nationality.value = '';
  }

  setSelectedCustomerService(String value, String id , whats , call) {
    selectedCustomerServiceName.value = value;
    selectedCustomerServiceId.value = id;
    selectedCustomerServiceWhats.value = whats;
    selectedCustomerServicePhone.value = call;
  }

  RxBool isAffirmingTheOrder = false.obs;

  affirmOrder() async {
   if( !validatePhoneNumber(phoneValue.value.text) ){
     return;
   }
    isAffirmingTheOrder.value = true;
    print("sent data is ${cvId.value} "
        "${selectedCustomerServiceId.value} "
        "${nameValue.value.text} "
        "${phoneValue.value.text}");
    try {
      var response = await apiService.postMethod(
endpoint: '/cvs/add/order',

          data: type.value == 'rent' ?
          {
            'name': nameValue.value.text.toString(),
            'phone': phoneValue.value.text.toString(),
            'cv_id': cvId.value.toString(),
            'cutomer_service_id': selectedCustomerServiceId.value.toString(),
            'latitude': lat.value.toString(),
            'longitude': long.value.toString(),
            'rent_start_date': rentStartDate.value.toString(),
            'rent_end_date': rentEndDate.value.toString()
          }
          :
          {
            'name': nameValue.value.text.toString(),
            'phone': phoneValue.value.text.toString(),
            'cv_id': cvId.value.toString(),
            'cutomer_service_id': selectedCustomerServiceId.value.toString()
          }
      );
      if (response.statusCode == 200) {
        print("your rent data is ${ {
          'name': nameValue.value.text.toString(),
          'phone': phoneValue.value.text.toString(),
          'cv_id': cvId.value.toString(),
          'cutomer_service_id': selectedCustomerServiceId.value.toString(),
          'latitude': lat.value.toString(),
          'longitude':    long.value.toString(),
          'rent_start_date': rentStartDate.value.toString(),
          'rent_end_date': rentEndDate.value.toString()
        }}");
        isAffirmingTheOrder.value = false;
        String extractTrackingNumber(String text) {
          final RegExp regex = RegExp(r'NK\d+');
          final match = regex.firstMatch(text);
          return match != null ? match.group(0) ?? '' : '';
        }
         print("the coming data" + response.data.toString());
        String trackNo = extractTrackingNumber(response.data['msg']);
         orderTrackNo.value = trackNo;
print("the track no is $orderTrackNo");
        await  Clipboard.setData(
            ClipboardData(
              text: trackNo, ));
        sendCustomerServiceNotification(selectedCustomerServiceId.value);
        Get.offAll(()=> SuccessView());
      }else {
        isAffirmingTheOrder.value = false;
        print("not 200 "+ response.data.toString());
        print("the coming data error here" + response.data.toString());
      }
    } catch (e) {

      print("error caught here $e" );
      isAffirmingTheOrder.value = false;

      ;
print("runtime type is  ${e.runtimeType}" );
    }

  }
  bool validatePhoneNumber(String? value) {
    final RegExp regex = RegExp(r'^5\d{8}$');
    if (value == null || value.isEmpty) {
      Get.snackbar('خطأ', 'من فضلك أدخل رقم هاتف صالح');
      return false;
    } else if (!regex.hasMatch(value)) {
      Get.snackbar('خطأ', 'من فضلك أدخل رقم هاتف صالح');
      return false;
    }
    return true;
  }


  sendCustomerServiceNotification(String id) async {
    await NotificationService.instance.getAccessToken();
    await SendNotificationToCustomerService(id);

  }

  SendNotificationToCustomerService(String id) async {
    //getting fcm token from firestore
    try{
      await FirebaseFirestore.instance.collection('employees').doc(id).get().then((value) async{


//preparing notification data
        var data = value.data();
        NotificationService.instance.getBody(
            fcmToken: data!['fcmToken'].toString(),
            title: "طلب جديد",
            body: "لديك طلب جديد",
            userId: id.toString());


//sending notification
        await NotificationService.instance.sendNotifications(
            fcmToken: data['fcmToken'].toString(),
            title: "طلب جديد",
            body: "لديك طلب جديد",
            userId: id.toString()
        );


      });

    }catch(e){
      print("not found  customer service $e");
    }




  }




  launchWhatsApp(phone) async {
    String url = "https://wa.me/+$phone?text=مرحبا";
    await launch(url);
  }

  launchCall(phone) async {
    String url = "tel://+$phone";
    await launch(url);
  }

  clearAllOrderDetails() {
    cvId.value = 0;
    nameValue.value.clear();
    phoneValue.value.clear();
    religion.value = '';
    nationality.value = '';
    job.value = '';
    experience.value = '';
    ageTo.value = '';
    ageFrom.value = '';
    experience.value = '';
    selectedCustomerServiceName.value = '';
    selectedCustomerServiceId.value = '';
    selectedCustomerServicePhone.value = '';
    selectedCustomerServiceWhats.value = '';
    orderTrackNo.value = '';
    lat.value = '';
    long.value = '';
    rentStartDate.value = '';
    rentEndDate.value = '';

  }

  setCvId(int id) {
    cvId.value = id;
  }

  RxBool isGettingLocation = false.obs;
  getCurrentLocation() async {
    await _handlePermission();

    isGettingLocation.value = true;
    try{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high).then((value) {
        isGettingLocation.value = false;
        lat.value = value.latitude.toString();
        // long.value =  value.longitude.isNegative ? value.longitude.abs().toString() :  value.longitude.toString();
        long.value = value.longitude.toString();
        print("the lat is ${lat.value} and the long is ${long.value} test");
        Get.snackbar('نجاح',  "تم تحديد الموقع بنجاح ",);
        return value;
      });
    }catch(e){
      isGettingLocation.value = false;
      Get.snackbar('خطأ',  "تأكد من تفعيل خدمة الموقع فى جهازك ",);
    }


  }
  Future<void> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text('من فضلك قم بتشغيل خدمة الموقع فى جهازك')));
      // return Future.error('من فضلك قم بتشغيل خدمة الموقع فى جهازك');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
      );
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
  }



}
