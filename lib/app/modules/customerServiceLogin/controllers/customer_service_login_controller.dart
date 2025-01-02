import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:robua/app/data/constants.dart';
import 'package:robua/app/modules/global/models/models.dart';
import 'package:robua/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../home/views/home_view.dart';
import '../views/customer_service_dashboard_view.dart';

class CustomerServiceLoginController extends GetxController {
  //TODO: Implement CustomerServiceLoginController

  final count = 0.obs;

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
  }

  void increment() => count.value++;

  RxBool isLoginLoading = false.obs;

  String employeeEmail = '';
  String employeeName = '';
  String employeeId = '';
  RxBool isExpanded = false.obs;

  login(email, password) async {
    employeeEmail = email;
    try {
      isLoginLoading.value = true;
      final reponse = await apiService.postMethod(
          endpoint: '/auth/login', data: {
        'email': email,
        'password': password
      });

      if (reponse.statusCode == 200) {
        employeeId = reponse.data['data']['user_info']['id'].toString();
        employeeName = reponse.data['data']['user_info']['name'];
        print("employe data $employeeId $employeeName $employeeEmail");
        await saveCustomerServiceToken();
        Get.off(
            CustomerServiceDashboardView(), transition: Transition.rightToLeft,
            preventDuplicates: false);
        Get.snackbar(
            'مرحبا', ' مرحبا بك ${reponse.data['data']['user_info']['name']}');
        Get.snackbar('التحقق من الإشعارات', 'الأن سيصلك اشعار بكل طلب جديد');
        isLoginLoading.value = false;
        AppConstants.userToken = reponse.data['data']['access_token'];
       await saveTokenToLocalDatabase(AppConstants.userToken);
        print("token is is ${AppConstants.userToken}");

        await getDashboardOrders();



      } else {
        Get.snackbar('خطأ', reponse.data['msg']);
        print("error logging in 1  ${reponse.data['msg']}");
        isLoginLoading.value = false;
      }
    } catch (e) {
      // Get.snackbar('خطأ', e.toString());
      print("error logging in 2 $e");
      isLoginLoading.value = false;
    }
  }


  RxList<OrderResponseInnerData> orders = <OrderResponseInnerData>[].obs;
  RxBool isOrdersLoading = false.obs;
  RxList<String> names = <String>[].obs;
  RxList<String> phones = <String>[].obs;
  List<String> orderStatuses = [
    "حجز السيرة الذاتيه",
    "تم التعاقد",
    "تم الربط في مساند",
    "تحت الاجراء و التدريب",
    "ختم التاشيره",
    "وصول العمالة",
    "ملغى"
  ];

  getDashboardOrders() async {
    try {
      orders.clear();
      names.clear();
      phones.clear();
      isOrdersLoading.value = true;

      final response = await apiService.getRequest('/admin/get_orders');

      if (response.statusCode == 200) {
        for (var order in response.data['data']) {
          orders.add(OrderResponseInnerData.fromJson(order));
          names.add(order['user']['name']);
          phones.add(order['user']['phone']);
          isOrdersLoading.value = false;
        }

        print("success getting orders ${response.data['data']}");
        print("success getting orders 2 ${orders}");
        print("success getting all orders  ${response
            .data['data']['user']['name']}");
        isOrdersLoading.value = false;
      } else {
        Get.snackbar('خطأ', response.data['msg']);
        isOrdersLoading.value = false;
        print("error getting orders ${response.data['msg']}");
      }
    }
    catch (e) {
      isOrdersLoading.value = false;
      print("error getting orders $e");
    }
  }

  RxBool isUpdatingOrderStatus = false.obs;
  RxString currentOrderId = ''.obs;
  RxBool isOrderUpdatedSuccessfully = false.obs;

  updateOrderStatus(id, isCancel) async {
    try {
      isOrderUpdatedSuccessfully.value = false;
      currentOrderId.value = id.toString();
      isUpdatingOrderStatus.value = true;
      final response = await apiService.postMethod(
          endpoint: '/admin/update_order_status', data: {
        'order_id': id,
        'cancel': isCancel ? 1 : 0
      });

      if (response.statusCode == 200) {
        Get.snackbar('نجاح', 'تم تحديث الحالة بنجاح');
        print("success updating order status ${response.data}");
        await getDashboardOrders();
        Get.off(
            CustomerServiceDashboardView(), transition: Transition.rightToLeft,
            preventDuplicates: true);

        isUpdatingOrderStatus.value = false;
        isOrderUpdatedSuccessfully.value = true;
      } else {
        Get.snackbar('خطأ', response.data['msg']);
        isUpdatingOrderStatus.value = false;
        isOrderUpdatedSuccessfully.value = false;
      }
    } catch (e) {
      isUpdatingOrderStatus.value = false;
      isOrderUpdatedSuccessfully.value = false;
    }
  }


  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else {
      Get.snackbar('خطأ', 'لا يمكن فتح الخريطة');
      throw 'Could not open the map.';
    }
  }


  saveCustomerServiceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Get the initial token
    String? token = await messaging.getToken();
    print('Initial FCM token: $token');
    if (token != null) {
      await saveTokenToFirestore(token);
    }

    // Handle token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('Refreshed FCM token: $newToken');
      saveTokenToFirestore(newToken);
    });
  }

  Future<void> saveTokenToFirestore(String token) async {
    FirebaseFirestore.instance.collection('employees').doc(employeeId).set(
        {
          'id': employeeId,
          'fcmToken': token,
          'email': employeeEmail,
          'name': employeeName,


        });
  }

  void toggleExpansion(int index) {
    orders[index].isExpanded = !orders[index].isExpanded;
    print(orders[index].isExpanded);
    orders.refresh(); // Refresh to update the UI
  }


  launchPhone(phone) async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }


  String getOrderStatus(String comingStatus) {
    print("your status $comingStatus");
    switch (comingStatus) {
      case 'ملغى':
        return 'ملغى';
      case 'حجز السيرة الذاتيه':
        return 'إتمام التعاقد';
      case 'تم التعاقد':
        return 'الربط فى مساند';
      case 'تم الربط في مساند ':
        return 'تحت الإجراء';
      case 'تحت الاجراء و التدريب':
        return 'ختم التأشيرة';
      case ' ختم التاشيره ':
        return 'وصول العمالة';
      case 'وصول العمالة':
        return '';
      default:
        return 'حجز السيرة الذاتيه';
    }
  }

  Future saveTokenToLocalDatabase(String? userToken) async {
    if (userToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_token', userToken);
    }
  }
}


