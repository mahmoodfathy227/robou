import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/constants.dart';
import '../../global/widget/widgets.dart';
import '../controllers/our_services_controller.dart';

class OurServicesView extends GetView<OurServicesController> {
  const OurServicesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خدماتنا' ,style: TextStyle(fontWeight: AppConstants.bold),),
        centerTitle: true,
      ),
      body: Column(


        children: [
          SizedBox(height: 70,),
          buildIstqdamServices(context),
        ],
      )
    );
  }
}
