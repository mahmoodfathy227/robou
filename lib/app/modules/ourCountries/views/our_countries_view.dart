import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:robua/app/modules/global/widget/widgets.dart';

import '../../../data/constants.dart';
import '../controllers/our_countries_controller.dart';

class OurCountriesView extends GetView<OurCountriesController> {
  const OurCountriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دول الاستقدام' , style: TextStyle(fontWeight: AppConstants.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(
              height: 150,
            ),

            buildOurOffers(context),

          ],
        ),
      )
    );
  }
}
