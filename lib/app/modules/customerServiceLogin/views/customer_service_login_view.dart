import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../data/colors.dart';
import '../../../data/constants.dart';
import '../controllers/customer_service_login_controller.dart';

class CustomerServiceLoginView extends GetView<CustomerServiceLoginController> {
  const CustomerServiceLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'تسجيل الدخول', style: TextStyle(fontWeight: AppConstants.bold),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(
                height: 4,
              ),

              LoginScreen(),

            ],
          ),
        )
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  CustomerServiceLoginController loginController = Get.put(
      CustomerServiceLoginController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/login.png'),
          // Replace with your image asset
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
onChanged: (value) {
  setState(() {

  });
},
            decoration: InputDecoration(
              labelText: 'البريد الالكتروني',

              errorText: _emailController.text.isEmpty
                  ? 'البريد الالكتروني مطلوب'
                  : null,
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),

          ),
          SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'الرقم السري',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(

                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              ),
              Text('تذكرني'),
            ],
          ),
          SizedBox(height: 20),
          Obx(() {
            return
              loginController.isLoginLoading.value ?

                  SpinKitThreeInOut(color: AppColors.secondaryColor,)
              :
              ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.secondaryColor),
              ),
              onPressed: () {
                // Handle login logic here
                loginController.login(
                    _emailController.text, _passwordController.text);
              },
              child: Text('تسجيل الدخول', style: TextStyle(

                  color: Colors.white

              ),),
            );
          }),
          SizedBox(height: 20),
          // TextButton(
          //   onPressed: () {
          //     // Handle forgot password logic here
          //   },
          //   child: Text('نسيت كلمة السر؟'),
          // ),
          // TextButton(
          //   onPressed: () {
          //     // Handle register new account logic here
          //   },
          //   child: Text('ليس لديك حساب؟ تسجيل حساب جديد'),
          // ),
        ],
      ),
    );
  }
}

