import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/data/constants.dart';
import 'package:robua/app/modules/customerServiceLogin/controllers/customer_service_login_controller.dart';
import 'package:robua/app/modules/customerServiceLogin/views/customer_service_login_view.dart';
import 'package:robua/app/modules/faq/views/faq_view.dart';
import 'package:robua/app/modules/global/models/models.dart';
import 'package:robua/app/modules/requests/controllers/requests_controller.dart';
import 'package:robua/app/modules/trackOrder/views/track_order_view.dart';

import '../../contactUs/views/contact_us_view.dart';
import '../../customerServiceLogin/views/customer_service_dashboard_view.dart';
import '../../global/widget/widgets.dart';
import '../../ourCountries/views/our_countries_view.dart';
import '../../ourServices/views/our_services_view.dart';
import '../../requests/views/requests_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final List<String> imgList = [
    'https://robuashaqraa.com/uploads/sliders/webp_s2.webp_1732215593.webp',
    'https://robuashaqraa.com/uploads/sliders/webp_s2.webp_1732215593.webp',
    'https://robuashaqraa.com/uploads/sliders/webp_s2.webp_1732215593.webp',
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),

      appBar: AppBar(

        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
              // controller.toggleDrawer,
            }


        ),
        actions: [
          CachedNetworkImage(
              imageUrl: 'https://robuashaqraa.com/frontend/img/logo/roboo3Logo.png')
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //Drawer Section
            //_buildDrawerWithLogo(context),
            //Carousel Section
            _buildCarousel(context),
            //Who we are Section
            _buildWhoWeAre(context),
            //Company Profile Section
            CompanyProfileCard(),
            //Our Features
            _buildOurFeatures(),
            //Istqdam Services
            buildIstqdamServices(context),
            //Customer Services
            _buildCustomerServices(context),
            //Our Offers
            buildOurOffers(context),
            //Our Statistics
            _buildOurStatistics(context),

            _buildOurRequests(context),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(() => ContactUsView());
      },
        backgroundColor: AppColors.secondaryColor,
        shape: CircleBorder(),
        child: Icon(
          Icons.headset,
          color: AppColors.primaryColor,
          size: 30,
        ),


      ),

    );
  }


  _buildCarousel(context) {
    RequestsController requestsController = Get.put<RequestsController>(RequestsController());
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.300,
          child: Obx(() {
            return
              controller.isHomeSliderLoading.value ?
              SpinKitThreeInOut(
                color: AppColors.secondaryColor,)
                  :
              Stack(
                children: [
                  //image with buttons an texts on center
                  CarouselSlider(
                    items: controller.homeSlider.map((item) =>
                        Stack(

                          alignment: Alignment.center,

                          children: [
                            CachedNetworkImage(
                              imageUrl: item.image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (_, __) =>
                                  Center(child: SpinKitThreeInOut(
                                    color: AppColors.secondaryColor,),),
                              errorWidget: (_, __, ___) => SizedBox(),

                            ),
                            //row of buttons + texts
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.11
                              ),
                              child: ShowUp(
                                delay: 400,
                                child: Column(
                                  children: [
                                    Text(item.title!, style:
                                    TextStyle(
                                        fontWeight: AppConstants.semiBold,
                                        color: AppColors.primaryColor),),
                                    Text(item.description!,
                                      style: TextStyle(
                                          fontWeight: AppConstants.bold,
                                          color: AppColors.primaryColor),),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      // Optional: Padding around the row
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        // Space between buttons
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(

                                              onPressed: () {
                                                // Handle Option 1
                                                requestsController
                                                    .clearAllOrderDetails();
                                                Get.to(() => RequestsView(
                                                  title: 'استقدام',));
                                                requestsController.type.value =
                                                'admission';
                                                requestsController.getCvs();
                                              },

                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(30.0),
                                                ),
                                                side: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                'طلب استقدام', style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColors
                                                      .secondaryColor,
                                                  fontWeight: AppConstants.bold

                                              ),),
                                            ),
                                          ),
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                // Handle Option 3
                                                requestsController
                                                    .clearAllOrderDetails();
                                                Get.to(() => RequestsView(
                                                  title: 'إيجار',));
                                                requestsController.type.value =
                                                'rent';
                                                requestsController.getCvs();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(30.0),
                                                ),
                                                side: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                'طلب تأجير', style: TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors
                                                      .secondaryColor,
                                                  fontWeight: AppConstants.bold

                                              ),),
                                            ),
                                          ),
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                // Handle Option 2
                                                requestsController
                                                    .clearAllOrderDetails();

                                                Get.to(() => RequestsView(
                                                  title: 'نقل خدمات',));
                                                requestsController.type.value =
                                                'transport';
                                                await requestsController.getCvs();

                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(30.0),
                                                ),
                                                side: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                'استلام فورى', style: TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors
                                                      .secondaryColor,
                                                  fontWeight: AppConstants.bold

                                              ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),


                    ).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        _currentIndex = index;
                      },
                    ),
                  ),
                  //build arrows
                  Positioned(
                    left: 0,
                    top: MediaQuery
                        .of(context)
                        .size
                        .height / 12, // Adjust vertical position as needed
                    child: IconButton(
                      icon: Icon(
                          Icons.arrow_forward, color: AppColors.primaryColor,
                          size: 30),
                      onPressed: () => _controller.previousPage(),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: MediaQuery
                        .of(context)
                        .size
                        .height / 12, // Adjust vertical position as needed
                    child: IconButton(
                      icon: Icon(
                          Icons.arrow_back, color: AppColors.primaryColor,
                          size: 30),
                      onPressed: () => _controller.nextPage(),
                    ),
                  ),

                ],
              );
          }),
        ),
        Transform.translate(
          offset: Offset(0, 125),
          child: Padding(
            padding: EdgeInsets.only(left: 150),
            child: Image.asset("assets/images/home/arrow.png", width: 270,),
          ),
        ),
      ],
    );
  }

  _buildWhoWeAre(context) {
    return ShowUp(
        delay: 400,
        child: Padding(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 75
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [

              Obx(() {
                return
                  controller.isAboutUsLoading.value ?
                  Center(child: SpinKitRotatingPlain(
                    color: AppColors.secondaryColor,
                    size: 80,
                  ))
                      :
                  Column(

                    children: [
                      ShowUp(
                        child: Text(controller.aboutUs.value.sectionTitle!,
                          style: TextStyle(fontWeight: AppConstants.bold,
                              fontSize: 25,
                              color: AppColors.secondaryColor),),),
                      ShowUp(
                        child: Text(controller.aboutUs.value.title!,

                          style: TextStyle(fontWeight: AppConstants.semiBold,
                              fontSize: 17,
                              color: Colors.black),),),
                      SizedBox(height: 10,),
                      ShowUp(
                        child: Text(
                          controller.aboutUs.value.description!,
                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: Colors.black),),),
                      SizedBox(height: 15,),
                      ShowUp(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.black,),
                            Text(

                              controller.aboutUs.value.service!,

                              style: TextStyle(
                                  fontWeight: AppConstants.semiBold,
                                  color: Colors.black),),

                          ],
                        ),),
                      SizedBox(height: 10,),
                      ShowUp(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.black,),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 70,
                              child: Text(


                                controller.aboutUs.value.license!,


                                style: TextStyle(
                                    fontWeight: AppConstants.semiBold,
                                    color: Colors.black),),
                            ),

                          ],
                        ),),
                      SizedBox(height: 10,),
                      ShowUp(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.black,),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 70,
                              child: Text(
                                controller.aboutUs.value.security!,
                                style: TextStyle(
                                    fontWeight: AppConstants.semiBold,
                                    color: Colors.black),),
                            ),

                          ],
                        ),),
                      SizedBox(height: 10,),
                      ShowUp(
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.black,),
                            Text(
                              controller.aboutUs.value.delivery!,

                              style: TextStyle(
                                  fontWeight: AppConstants.semiBold,
                                  color: Colors.black),),

                          ],
                        ),),
                    ],
                  ).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms);
              }),
            ],
          ),
        )
    );
  }

  _buildOurFeatures() {
    return ShowUp(
      delay: 400,
      child:


      Obx(() {
        List icons = [];
        List constIcons = [
          Icons.headset_mic_outlined,
          Icons.laptop,
          Icons.groups
        ];
        for (var i = 0; i < controller.aboutUs.value.features.length; i++) {
          int randomIndex = Random().nextInt(constIcons.length);
          icons.add(constIcons[randomIndex]);
        }
        return
          controller.isAboutUsLoading.value ?
          SizedBox()

              :

          Column(
              children:
              controller.aboutUs.value.features.map((Feature feature) =>
                  Material(
                    elevation: 20,
                    color: Colors.grey[100],
                    child: Container(

                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),


                        ),
                        child:


                        Column(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    icons[controller.aboutUs.value.features
                                        .indexOf(feature)],
                                    color: AppColors.secondaryColor, size: 45,),
                                  SizedBox(height: 20,),

                                  Text(feature.title!,
                                    style: TextStyle(
                                        fontWeight: AppConstants.bold,
                                        fontSize: 25,
                                        color: Colors.black),),
                                  SizedBox(height: 20,),
                                  Text(
                                    feature.desc!
                                    , style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.grey),),
                                ]),
                          ],
                        )),
                  ),
              ).toList());

        // [
        // controller.aboutUs.value.features.map((Features feature) =>
        //
        // ).toList()
        // // Material(
        // //   elevation: 20,
        // //   color: Colors.grey[100],
        // //   child: Container(
        // //
        // //       padding: EdgeInsets.all(16.0),
        // //       margin: EdgeInsets.all(16.0),
        // //       decoration: BoxDecoration(
        // //         color: Colors.white,
        // //         borderRadius: BorderRadius.only(
        // //           topRight: Radius.circular(5.0),
        // //           bottomLeft: Radius.circular(5.0),
        // //           bottomRight: Radius.circular(30.0),
        // //           topLeft: Radius.circular(30.0),
        // //         ),
        // //
        // //
        // //       ),
        // //       child:
        // //
        // //
        // //       Column(
        // //         children: [
        // //           Column(
        // //               crossAxisAlignment: CrossAxisAlignment.start,
        // //               children: [
        // //                 Icon(Icons.headset_mic_outlined,
        // //                   color: AppColors.secondaryColor, size: 45,),
        // //                 SizedBox(height: 20,),
        // //
        // //                 Text("خدمة عملاء مميزة",
        // //                   style: TextStyle(fontWeight: AppConstants.bold,
        // //                       fontSize: 25,
        // //                       color: Colors.black),),
        // //                 SizedBox(height: 20,),
        // //                 Text(
        // //                   " فريق خدمة العملاء معكم خطوة بخطوة بدءاَ من طلب استقدام عمالة منزلية حتى وصول العمالة"
        // //                   , style: TextStyle(fontWeight: FontWeight.w400,
        // //                     fontSize: 15,
        // //                     color: Colors.grey),),
        // //               ]),
        // //         ],
        // //       )),
        // // ),
        // // Material(
        // //   elevation: 20,
        // //   color: Colors.grey[100],
        // //   child: Container(
        // //
        // //       padding: EdgeInsets.all(16.0),
        // //       margin: EdgeInsets.all(16.0),
        // //       decoration: BoxDecoration(
        // //         color: Colors.white,
        // //         borderRadius: BorderRadius.only(
        // //           topRight: Radius.circular(5.0),
        // //           bottomLeft: Radius.circular(5.0),
        // //           bottomRight: Radius.circular(30.0),
        // //           topLeft: Radius.circular(30.0),
        // //         ),
        // //
        // //
        // //       ),
        // //       child:
        // //
        // //
        // //       Column(
        // //         children: [
        // //           Column(
        // //               crossAxisAlignment: CrossAxisAlignment.start,
        // //               children: [
        // //                 Icon(Icons.laptop, color: AppColors.secondaryColor,
        // //                   size: 45,),
        // //                 SizedBox(height: 20,),
        // //
        // //                 Text(" خدمات استقدام رقمية متكامل ",
        // //                   style: TextStyle(fontWeight: AppConstants.bold,
        // //                       fontSize: 25,
        // //                       color: Colors.black),),
        // //                 SizedBox(height: 20,),
        // //                 Text(
        // //                   " خطوات بسيطة تفصلك عن استقدام العمالة المنزلية التي تحتاجها.روافد نجد لخدمات استقدام"
        // //                   , style: TextStyle(fontWeight: FontWeight.w400,
        // //                     fontSize: 15,
        // //                     color: Colors.grey),),
        // //               ]),
        // //         ],
        // //       )),
        // // ),
        // // Material(
        // //   elevation: 20,
        // //   color: Colors.grey[100],
        // //   child: Container(
        // //
        // //       padding: EdgeInsets.all(16.0),
        // //       margin: EdgeInsets.all(16.0),
        // //       decoration: BoxDecoration(
        // //         color: Colors.white,
        // //
        // //
        // //       ),
        // //       child:
        // //
        // //
        // //       Column(
        // //         children: [
        // //           Column(
        // //               crossAxisAlignment: CrossAxisAlignment.start,
        // //               children: [
        // //                 Icon(Icons.groups, color: AppColors.secondaryColor,
        // //                   size: 45,),
        // //                 SizedBox(height: 20,),
        // //
        // //                 Text(" المتابعة المستمرة والتطوير الشامل ",
        // //                   style: TextStyle(fontWeight: AppConstants.bold,
        // //                       fontSize: 25,
        // //                       color: Colors.black),),
        // //                 SizedBox(height: 20,),
        // //                 Text(
        // //                   " نوفر كافة الإمكانيات لمتابعة احتياجات العملاء وتسهيل عملهم بسرعة فائقة. كما نطور خدماتنا"
        // //                   , style: TextStyle(fontWeight: FontWeight.w400,
        // //                     fontSize: 15,
        // //                     color: Colors.grey),),
        // //               ]),
        // //         ],
        // //       )),
        // // ),
        //   ],
        // );
      }).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms),
    );
  }


  _buildCustomerServices(context) {
    return ShowUp(
      delay: 400,
      child:

      Obx(() {
        return
          controller.isCustomerServiceLoading.value ?
          SizedBox()
              :

          Column(
            children: [
              SizedBox(height: 30,),
              Text("خدمة العملاء والمبيعات", style: TextStyle(
                  fontWeight: AppConstants.bold, color: Colors.black),),
              SizedBox(height: 10,),
              Text(" يمكنك التواصل مع طاقمنا المميز بكل سهولة ويسر ",
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.black),),
              SizedBox(height: 10,),
              Container(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _buildCustomerRepresetativeCard(
                          context: context,
                          data: controller.customerServices.value.data[index]
                      ),
                  separatorBuilder: (context, index) => SizedBox(width: 20,),
                  itemCount: controller.customerServices.value.data.length,),
              ),
              SizedBox(height: 10,),

            ],
          );
      }).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms),
    );
  }

  _buildCustomerRepresetativeCard(
      {context, required CustomerServiceInnerData data}) {
    return Container(

        height: 220,
        width: MediaQuery
            .of(context)
            .size
            .width / 1.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffE4EAEE),
        ),
        child:


        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: data.image!,
                  fit: BoxFit.cover,
                  width: 80,
                ),
              ),
              SizedBox(height: 20,),
              Text(data.name!, style: TextStyle(
                  fontWeight: FontWeight.w200, color: Colors.black),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.launchWhatsApp(data.whatsApp!);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                          "https://robuashaqraa.com/frontend/img/wh_icon.png"),

                    ),
                  ),
                  SizedBox(width: 30,),
                  GestureDetector(
                    onTap: () {
                      controller.launchCall(data.phone!);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                          "https://robuashaqraa.com/frontend/img/call_icon.png"),


                    ),
                  ),
                ],
              ),
            ]));
  }


  _buildOurStatistics(context) {
    List icons = [];
    List constIcons = [
      Icons.groups,
      Icons.location_on,
      Icons.headphones,
      Icons.shopping_bag

    ];
    for (int i = 0; i < controller.ourStatistics.length; i++) {
      int randomIndex = Random().nextInt(constIcons.length);
      icons.add(constIcons[randomIndex]);
    }
    return ShowUp(
      delay: 400,
      child:


      Obx(() {
        return
          controller.isStatisticsLoading.value ?
          SizedBox()
              :

          Column(

              children: [
                SizedBox(height: 30,),
                Text(
                  "الاحصائيات", style: TextStyle(fontWeight: AppConstants.bold,
                    color: Colors.black,
                    fontSize: 20),),
                SizedBox(height: 10,),
                Text(" إليك بعض إحصائيات العملاء الذين تشرفنا بالعمل معهم ",
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.black),),
                SizedBox(height: 20,),
                Obx(() {
                  return Container(

                    height: 240,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          _buildStatisticsCard(
                            context: context,
                            title: controller.statictics.value.data[index].title
                                .toString(),
                            icon: icons[index],
                            number: controller.statictics.value.data[index]
                                .number.toString(),
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 20,),
                      itemCount: controller.statictics.value.data.length,),
                  );
                })
              ]).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms);
      }),
    );
  }

  _buildStatisticsCard(
      {required BuildContext context, dynamic icon, required title, required number}) {

    return Material(
      elevation: 15,
      color: Colors.white,
      child: Container(
          height: 220,
          width: 180,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Icon(icon, color: AppColors.secondaryColor, size: 50,),
                Spacer(),
                Text(number, style:
                TextStyle(fontWeight:
                FontWeight.w300, color: Colors.black,
                    fontSize: 20
                ),),
                Spacer(),
                Text(title, style:
                TextStyle(fontWeight:
                FontWeight.w300, color: Colors.black,
                    fontSize: 20
                ),),
                SizedBox(height: 10,)
              ])
      ),
    );
  }

  _buildOurRequests(context) {
    return ShowUp(
      delay: 400,
      child:

      Obx(() {
        return
          controller.isStepsLoading.value ? SizedBox() :

          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Text(controller.steps.value.data!.title!,
                  style: TextStyle(fontWeight: AppConstants.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),),
                SizedBox(height: 10,),
                Text(controller.steps.value.data!.recruitmentStepDesc!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),),
                SizedBox(height: 10,),
                Material(
                  elevation: 5,
                  color: Colors.grey.shade100,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 400,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 50,
                    child: Directionality(

                      textDirection: TextDirection.ltr,
                      child: Column(

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 100,
                                child: Text(
                                  textAlign: TextAlign.end,

                                  controller.steps.value.data!
                                      .recruitmentStep1Desc!,
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 13
                                  ),),
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.web, color: AppColors.secondaryColor,)
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 100,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  controller.steps.value.data!
                                      .recruitmentStep2Desc!,
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 13
                                  ),),
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.web, color: AppColors.secondaryColor,)
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 100,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  controller.steps.value.data!
                                      .recruitmentStep3Desc!,
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 13
                                  ),),
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.web, color: AppColors.secondaryColor,)
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 100,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  controller.steps.value.data!
                                      .recruitmentStep4Desc!,
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 13
                                  ),),
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.web, color: AppColors.secondaryColor,)
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 100,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  controller.steps.value.data!
                                      .recruitmentStep5Desc!,
                                  style: TextStyle(fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 13
                                  ),),
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.web, color: AppColors.secondaryColor,)
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),
                // Material(
                //   elevation: 5,
                //   color: Colors.grey.shade100,
                //   child: Container(
                //     padding: EdgeInsets.all(8),
                //     height: 400,
                //     width: MediaQuery
                //         .of(context)
                //         .size
                //         .width - 50,
                //     child: Directionality(
                //
                //       textDirection: TextDirection.ltr,
                //       child: Column(
                //
                //         children: [
                //           Text("  اجراءات الاستقدام", style: TextStyle(
                //               fontWeight: AppConstants.bold,
                //               color: AppColors.secondaryColor,
                //               fontSize: 17),),
                //           SizedBox(height: 10,),
                //           Container(
                //             width: 300,
                //             child: Text(
                //               " الدخول الى منصة مساند التحقق من تأهيلك للحصول على التأشيرة ادخال البيانات المطلوبة واثبات القدرة المالية لإقرار بالمعلومات الصحيحة وسداد الرسوم من هنا ",
                //               maxLines: 5,
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 fontWeight: FontWeight.w400, color: Colors.black,
                //                 fontSize: 15,
                //
                //
                //               ),),
                //           ),
                //           SizedBox(height: 35,),
                //           Row(
                //
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Container(
                //                 width: 230,
                //                 child: Text("  الدخول الى منصة مساند ",
                //                   maxLines: 3,
                //                   textAlign: TextAlign.center,
                //                   style: TextStyle(fontWeight: FontWeight.w400,
                //                       color: Colors.black,
                //                       fontSize: 17
                //                   ),),
                //               ),
                //               SizedBox(width: 5,),
                //               Icon(Icons.pending_actions,
                //                 color: AppColors.secondaryColor,)
                //             ],
                //           ),
                //
                //           SizedBox(height: 15,),
                //           Row(
                //
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Container(
                //                 width: 230,
                //                 child: Text(
                //                   " التحقق من تأهيلك للحصول على تخليص اجراءات الاستقدام ",
                //                   maxLines: 3,
                //                   textAlign: TextAlign.center,
                //                   style: TextStyle(fontWeight: FontWeight.w400,
                //                       color: Colors.black,
                //                       fontSize: 17
                //                   ),),
                //               ),
                //               SizedBox(width: 5,),
                //               Icon(Icons.card_giftcard,
                //                 color: AppColors.secondaryColor,)
                //             ],
                //           ),
                //           SizedBox(height: 15,),
                //           Row(
                //
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Container(
                //                 width: 230,
                //                 child: Text(
                //                   "  ادخال البيانات المطلوبة واثبات القدرة المالية ",
                //                   maxLines: 3,
                //                   textAlign: TextAlign.center,
                //                   style: TextStyle(fontWeight: FontWeight.w400,
                //                       color: Colors.black,
                //                       fontSize: 17
                //                   ),),
                //               ),
                //               SizedBox(width: 5,),
                //               Icon(Icons.monetization_on,
                //                 color: AppColors.secondaryColor,)
                //             ],
                //           ),
                //           SizedBox(height: 15,),
                //           Row(
                //
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Container(
                //                 width: 230,
                //                 child: Text(
                //                   "  الإقرار بالمعلومات الصحيحة وسداد الرسوم  ",
                //                   maxLines: 3,
                //                   textAlign: TextAlign.center,
                //                   style: TextStyle(fontWeight: FontWeight.w400,
                //                       color: Colors.black,
                //                       fontSize: 17
                //                   ),),
                //               ),
                //               SizedBox(width: 5,),
                //               Icon(
                //                 Icons.headset, color: AppColors.secondaryColor,)
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //
                //   ),
                // ),

              ]);
      }).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms),
    );
  }


}

class CompanyProfileCard extends StatelessWidget {

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return ShowUp(
      delay: 400,
      child: Obx(() {
        return
          controller.isAboutUsLoading.value ?
          SizedBox() :
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),

                ),
                border: Border(
                    left: BorderSide(
                      color: Colors.yellow,
                      width: 5.0,
                    ),
                    right: BorderSide(
                      color: Colors.yellow,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.yellow,
                      width: 5.0,
                    ),
                    top: BorderSide(
                      color: Colors.yellow,
                      width: 1.0,
                    )
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 8.0),
                      Text(
                        'ذهبي',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 8.0),
                      Text(
                        'شركة ربوع شقراء للاستقدام',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.location_city, color: Colors.grey),
                      SizedBox(width: 8.0),
                      Text('مدن متعددة'),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 8.0),
                      Text('4.3'),
                      SizedBox(width: 8.0),
                      Text('(1099)'),
                    ],
                  ),
                  SizedBox(height: 8.0),

                ],
              ),
            ),
          ).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms);
      }),
    );
  }

}

class HorizontalDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  HorizontalDrawerItem(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.0,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 30.0),
            SizedBox(height: 8.0),
            Text(label, style: TextStyle(fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RequestsController requestsController = Get.find<RequestsController>();
    HomeController homeController = Get.find<HomeController>();

    return Drawer(
        child: ListView(


          children: [
            SizedBox(height: 50,),
            ListTile(
              leading: Icon(
                  Icons.account_circle, color: AppColors.secondaryColor),
              title: Text(
                  'الرئيسية', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                Get.back();
                // controller.toggleDrawer;
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_back_ios_outlined,
                  color: AppColors.secondaryColor),
              title: Text(
                  'الطلبات', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                showOptionsDialog(context);
                // controller.toggleDrawer;
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.panorama_fish_eye, color: AppColors.secondaryColor),
              title: Text('خدماتنا', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                Get.to(OurServicesView());
                // controller.toggleDrawer;
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.ad_units_sharp, color: AppColors.secondaryColor),
              title: Text(
                  'دول الاستقدام', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                Get.to((OurCountriesView()));
                // controller.toggleDrawer;
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.track_changes, color: AppColors.secondaryColor),
              title: Text(
                  'تتبع طلبك', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                Get.to(TrackOrderView());
                // controller.toggleDrawer;
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.question_mark, color: AppColors.secondaryColor),
              title: Text(
                  'الأسئلة الشائعة', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                Get.to(FaqView());
                // controller.toggleDrawer;
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.quick_contacts_dialer, color: AppColors.secondaryColor),
              title: Text(
                  'تواصل معنا', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle navigation or action
                Get.to(() => ContactUsView());
                // controller.toggleDrawer;
              },
            ),

            // who we are
            ListTile(
              leading: Icon(
                  Icons.person_search, color: AppColors.secondaryColor),
              title: Text(
                  'من نحن', style: TextStyle(color: Colors.black)),
              onTap: () async{
                // Handle navigation or action
              await homeController.launchMyUrl('https://robuashaqraa.com/about-us');
                // controller.toggleDrawer;
              },
            ),

            // privacy policy
            ListTile(
              leading: Icon(
                  Icons.policy, color: AppColors.secondaryColor),
              title: Text(
                  'سياسة الخصوصية', style: TextStyle(color: Colors.black)),
              onTap: () async{
                // Handle navigation or action
                await homeController.launchMyUrl('https://robuashaqraa.com/usage-policy');
                // controller.toggleDrawer;
              },
            ),
            // terms of use
            ListTile(
              leading: Icon(
                  Icons.indeterminate_check_box_sharp, color: AppColors.secondaryColor),
              title: Text(
                  'شروط الاستخدام', style: TextStyle(color: Colors.black)),
              onTap: () async{
                // Handle navigation or action
                await homeController.launchMyUrl('https://robuashaqraa.com/terms-of-use');
                // controller.toggleDrawer;
              },
            ),
            OutlinedButton(

              onPressed: () {
                CustomerServiceLoginController customerServiceLoginController = Get.find<CustomerServiceLoginController>();
                // Handle Option 1
                // requestsController.clearAllOrderDetails();
                // Get.to(() => RequestsView(title: 'استقدام',));
                // requestsController.type.value = 'admission';
                // requestsController.getCvs();
                if(AppConstants.userToken == null){
                  Get.to( CustomerServiceLoginView());
                } else {
                  customerServiceLoginController.getDashboardOrders();
                  Get.to( CustomerServiceDashboardView());
                }

              },

              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                side: BorderSide(color: Colors.blue),
              ),
              child: AppConstants.userToken == null ? Column(
                children: [
                  SizedBox(height: 5,),
                  Text('تسجيل الدخول', style: TextStyle(
                      color: AppColors.secondaryColor
                  ),),
                  Text('(خاص بخدمة العملاء)', style: TextStyle(
                      color: AppColors.secondaryColor
                  ),),
SizedBox(height: 5,)
                ],
              ) : Column(
                children: [
                  SizedBox(height: 5,),
                  Text('الصفحة الرئيسية', style: TextStyle(
                      color: AppColors.secondaryColor
                  ),),
                  Text('(خاص بخدمة العملاء)', style: TextStyle(
                      color: AppColors.secondaryColor
                  ),),
                  SizedBox(height: 5,)
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        )
    );
  }

  void showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        RequestsController requestsController = Get.find<RequestsController>();
        return SimpleDialog(

          title: Text('اختر نوع الطلب'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // Navigator.pop(context);
                // Handle Option 1
                requestsController.clearAllOrderDetails();
                Get.back();
                Get.to(() => RequestsView(title: 'استقدام',));
                requestsController.type.value = 'admission';
                requestsController.getCvs();
              },
              child: Text('طلب استقدام',
                style: TextStyle(color: AppColors.secondaryColor),),
            ),
            SimpleDialogOption(
              onPressed: () {
                // Handle Option 2
                requestsController.clearAllOrderDetails();
                Get.back();
                Get.to(() => RequestsView(title: 'نقل خدمات',));
                requestsController.type.value = 'transport';
                requestsController.getCvs();
              },
              child: Text('طلب نقل خدمات',
                style: TextStyle(color: AppColors.secondaryColor),),
            ),
            SimpleDialogOption(
              onPressed: () {
                // Handle Option 3
                requestsController.clearAllOrderDetails();
                Get.back();
                Get.to(() => RequestsView(title: 'إيجار',));
                requestsController.type.value = 'rent';
                requestsController.getCvs();
              },
              child: Text('طلب إيجار',
                style: TextStyle(color: AppColors.secondaryColor),),
            ),
          ],
        );
      },
    );
  }
}

