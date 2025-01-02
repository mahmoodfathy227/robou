import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/modules/contactUs/views/contact_us_view.dart';
import 'package:robua/app/modules/global/models/models.dart';
import 'package:robua/app/modules/requests/views/order_view.dart';

import '../../../data/constants.dart';
import '../controllers/requests_controller.dart';
import 'details_view.dart';
import 'image_view.dart';


class RequestsView extends GetView<RequestsController> {
  const RequestsView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              !controller.isExpanded.value ? 80 : 180.0),
          // Height of the app bar
          child: AppBar(
            title: Row(
              children: [
                Text('طلب $title'),
                Spacer(),
                IconButton(
                  icon: CircleAvatar(
                      backgroundColor: AppColors.secondaryColor,
                      child: Icon(Icons.filter_list_alt,
                        color: Colors.white,)),
                  onPressed: () {
                    // Handle filter icon press
                    controller.isExpanded.toggle();
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: !controller.isExpanded.value ? SizedBox() : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Column(

                    children: [
                      Expanded(
                        child: Padding(
                          padding:  EdgeInsets.only(right: 20),
                          child: ListView(

                            scrollDirection: Axis.horizontal,
                            children: [Row(
                              children: [
                                //Experience
                                Row(
                                  children: [
                                    Text(controller.experience.value.isEmpty? "الخبرة " : controller.experience.value),
                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.filter_list),
                                      onSelected: (String value) {
                                         // _selectedFilter = value;
                                        controller.experience.value = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return controller.cv.value.experience

                                      .map((Experience experience) {
                                          return PopupMenuItem<String>(
                                            value: experience.title,
                                            child: Text(experience.title!),
                                          );
                                        }).toList();
                                      },
                                    ),

                                  ],
                                ),
                                //Job
                                Row(
                                  children: [
                                    Text(controller.job.value.isEmpty? "المهنة " : controller.job.value),


                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.filter_list),
                                      onSelected: (String value) {

                                        controller.job.value = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return
                                          controller.cv.value.jobs
                                         .map((Experience job) {
                                          return PopupMenuItem<String>(
                                            value: job.title,
                                            child: Text(job.title!),
                                          );
                                        }).toList();
                                      },
                                    ),

                                  ],
                                ),
                                //Religion
                                Row(
                                  children: [
                                    Text(controller.religion.value.isEmpty? "الديانة " : controller.religion.value),


                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.filter_list),
                                      onSelected: (String value) {
                                   controller.religion.value = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return

                                          controller.cv.value.religion.map
                                            ((Experience religion) {
                                          return PopupMenuItem<String>(
                                            value: religion.title,
                                            child: Text(religion.title!),
                                          );
                                        }).toList();
                                      },
                                    ),

                                  ],
                                ),
                                //Nationality
                                Row(
                                  children: [
                                    Text(controller.nationality.value.isEmpty? "الجنسية " : controller.nationality.value),


                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.filter_list),
                                      onSelected: (String value) {

                                        controller.nationality.value = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return
                                          controller.cv.value.nationalities

                                          .map((Nationality nationality) {
                                          return PopupMenuItem<String>(
                                            value: nationality.title,
                                            child: Text(nationality.title!),
                                          );
                                        }).toList();
                                      },
                                    ),

                                  ],
                                ),

                                //AgeFrom
                                Row(
                                  children: [
                                    Text(controller.ageFrom.value.isEmpty? "العمر من " : controller.ageFrom.value),


                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.filter_list),
                                      onSelected: (String value) {

                                        controller.ageFrom.value = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return
                                          controller.ageFromList

                                              .map((String age) {
                                            return PopupMenuItem<String>(
                                              value: age,
                                              child: Text(age),
                                            );
                                          }).toList();
                                      },
                                    ),

                                  ],
                                ),

                                //AgeTo
                                Row(
                                  children: [
                                    Text(controller.ageTo.value.isEmpty? "العمر إلى " : controller.ageTo.value),


                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.filter_list),
                                      onSelected: (String value) {

                                        controller.ageTo.value = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return
                                          controller.ageToList

                                              .map((String age) {
                                            return PopupMenuItem<String>(
                                              value: age,
                                              child: Text(age),
                                            );
                                          }).toList();
                                      },
                                    ),

                                  ],
                                ),

                              ],
                            ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(onPressed: () {
                            controller.getCvs();
                          },
                            color: AppColors.secondaryColor,
                            child: Text("تطبيق",
                              style: TextStyle(color: AppColors.primaryColor),),),
                          SizedBox(width: 10,),

                          MaterialButton(
                            onPressed: () => controller.clearFilter(),
                            color: Colors.red,
                            child: Row(
                              children: [
                                GestureDetector(

                                    child: Text("مسح", style: TextStyle(color: Colors.white),)),
                                Icon(Icons.refresh, color: AppColors.primaryColor,)
                              ],
                            ),),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              )
                  .animate()
              .fadeIn(duration: 400.ms)
              .slideX(duration: 400.ms)
              ,
            ),
          ),
        ),
        body: Obx(() {
          return Center(
              child: controller.isCvLoading.value ?
              SpinKitThreeInOut(
                  color: AppColors.secondaryColor
              )
                  :
              controller.cv.value.cvs.isEmpty?
              Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(Icons.search_off , size: 200, color: AppColors.secondaryColor,),
                      SizedBox(height: 20,),
                      Text("لا يوجد نتائج", style: TextStyle(
                          color: AppColors.secondaryColor,
                      fontSize: 25
                      ),),
                    ],
                  )
              )
              :
              ListView.separated(
                  itemBuilder: (context, index) {
                    return
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Hero(
                                tag: controller.cv.value.cvs[index].image!,
                                child: CachedNetworkImage(
                                    imageUrl: controller.cv.value.cvs[index]
                                        .image!,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 40,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Image.asset(
                                          "assets/images/logo.jpeg",
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width - 40,
                                          fit: BoxFit.cover,
                                        )

                                ),
                              ),
                              IconButton(onPressed: () {
                                print("tapped");
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        ImageView(controller.cv.value.cvs[index]
                                            .image!)));
                              },
                                  icon: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: AppColors.secondaryColor,
                                    child: Center(
                                      child: Icon(Icons.zoom_in_rounded,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(height: 21,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3,
                                child: MaterialButton(

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: AppColors.secondaryColor,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsView(controller.cv.value
                                                .cvs[index],
                                            false,
                                              null,
                                              ""
                                            )));
                                  },
                                  child: Text('التفاصيل', style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),),


                                ),
                              ),
                              SizedBox(width: 20,),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: AppColors.secondaryColor,
                                  onPressed: () {
                                    controller.setCvId(controller.cv.value.cvs[index].id!);
Get.to(()=> OrderView());
                                  },
                                  child: Text('احجز الأن', style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),),


                                ),
                              )
                            ],
                          )
                        ],
                      );
                  },
                  separatorBuilder: (context, index) =>
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: AppColors.secondaryColor,),
                      ),
                  itemCount: controller.cv.value.cvs.length)
          );
        }),
      );
    });
  }
}

class FilterOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const FilterOption({
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(value),
      ],
    );
  }
}

