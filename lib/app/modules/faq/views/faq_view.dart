import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:robua/app/modules/global/widget/widgets.dart';

import '../../../data/colors.dart';
import '../../../data/constants.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأسئلة الشائعة', style: TextStyle(fontWeight: AppConstants.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ShowUp(
          delay: 400,
          child: Column(
            children: [
              SizedBox(height: 50,),
              ExpansionTile(

                collapsedBackgroundColor: Color(0xffF5F4DE),
                collapsedIconColor: AppColors.secondaryColor,

                title: Text('كيف يتم تخليص اجراءات الاستقدام ؟', style: TextStyle(fontWeight: AppConstants.bold,
                    color: AppColors.secondaryColor),),
                children: <Widget>[
                  ListTile(
                    title: Text('1- فتح حساب في مساند'),
                  ),
                  ListTile(
                    title: Text('2- ادخل حسابي'),
                  ),
                  ListTile(
                    title: Text('3- لوحة التحكم'),
                  ),
                  ListTile(
                    title: Text('4- اصدار تأشيرة'),
                  ),
                  ListTile(
                    title: Text('5- تأشيرة عاملة منزلية'),
                  ),
                  ListTile(
                    title: Text('6- الجنسية (كينيا –نيروبي)'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
