import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:robua/app/modules/contactUs/views/contact_us_view.dart';
import 'package:robua/app/modules/home/controllers/home_controller.dart';

import '../../../data/colors.dart';
import '../../../data/constants.dart';
import '../../requests/controllers/requests_controller.dart';
import '../../requests/views/requests_view.dart';
import '../models/models.dart';

class ShowUp extends StatefulWidget {
  final Widget? child;
  final int? delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        if (mounted) _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}


buildIstqdamServices(context) {
  HomeController controller = Get.find<HomeController>();

  return ShowUp(
    delay: 400,
    child: Obx(() {
      List<GlobalKey<FlipCardState>> cardStateKeys = List.generate(
          controller.services.value.data.length,
              (index) => GlobalKey<FlipCardState>());
      return
        controller.isServicesLoading.value ? SizedBox() :
        Column(
          children: [
            SizedBox(height: 20,),
            Text(
              "خدمات استقدام", style: TextStyle(fontWeight: AppConstants.bold,
                fontSize: 25,
                color: Colors.black),),
            Text("تعرف على الخدمات التى نقدمها لعملائنا",
              style: TextStyle(fontWeight: AppConstants.bold,
                  fontSize: 16,
                  color: Colors.grey),),
            SizedBox(height: 20,),
            Container(
              height: 500,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children:
                  controller.services.value.data.map((
                      ServiceInnerData service) =>
                      FlipCard(
                        key: cardStateKeys[controller.services.value.data
                            .indexOf(service)],

                        flipOnTouch: false,
                        front: Container(

                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.white,

                          ),
                          child: MaterialButton(
                            onPressed: () =>
                                cardStateKeys[controller.services.value.data
                                    .indexOf(service)].currentState
                                    ?.toggleCard(),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CachedNetworkImage(imageUrl: service.image!,
                                  fit: BoxFit.cover,
                                  height: 500,
                                  placeholder: (context, url) =>
                                      Image.asset(
                                        "assets/images/logo.jpeg",
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width: 300,
                                      ),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(service.title!,
                                        style: TextStyle(
                                            fontWeight: AppConstants.bold,
                                            fontSize: 25,
                                            color: Colors.white),),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.home_repair_service_rounded,
                                      color: Colors.white,),
                                    SizedBox(width: 10,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        back: Container(

                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.white,

                          ),
                          child: MaterialButton(
                            onPressed: () =>
                                cardStateKeys[controller.services.value.data
                                    .indexOf(service)].currentState
                                    ?.toggleCard(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/logo.jpeg",
                                  fit: BoxFit.cover, height: 100,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(service.title!, style: TextStyle(
                                      fontWeight: AppConstants.bold,
                                      fontSize: 25,
                                      color: AppColors.secondaryColor),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    service.desc!,
                                    style: TextStyle(
                                        fontWeight: AppConstants.bold,
                                        fontSize: 15,
                                        color: Colors.grey),),
                                ),

                              ],
                            ),
                          ),
                        ),
                      )
                  ).toList()
                // [
                //   FlipCard(
                //     key: cardKey1,
                //     flipOnTouch: false,
                //     front: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey1.currentState?.toggleCard(),
                //         child: Stack(
                //           alignment: Alignment.bottomRight,
                //           children: [
                //             Image.asset("assets/images/home/service1.webp", fit: BoxFit.cover,
                //               height: 500,
                //             ),
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text("اصدار التأشيرة", style: TextStyle(fontWeight: AppConstants.bold,
                //                       fontSize: 25,
                //                       color: Colors.white),),
                //                 ),
                //                 Spacer(),
                //                 Icon(Icons.shopping_bag , color: Colors.white,),
                //                 SizedBox(width: 10,)
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     back: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey1.currentState?.toggleCard(),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Image.network("https://robuashaqraa.com/frontend/img/logo/roboo3Logo.png"
                //               , fit: BoxFit.cover,
                //
                //               height: 100,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("اصدار التأشيرة", style: TextStyle(fontWeight: AppConstants.bold,
                //                   fontSize: 25,
                //                   color: AppColors.secondaryColor),),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(" طلب اصدار تاشيرة العمالة المنزلية الخاصة بك في برنامج",
                //                 style: TextStyle(fontWeight: AppConstants.bold,
                //                     fontSize: 15,
                //                     color: Colors.grey),),
                //             ),
                //
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(width: 10,),
                //   FlipCard(
                //     key: cardKey2,
                //     flipOnTouch: false,
                //     front: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey2.currentState?.toggleCard(),
                //         child: Stack(
                //           alignment: Alignment.bottomRight,
                //           children: [
                //             Image.asset("assets/images/home/service2.webp", fit: BoxFit.cover,
                //               height: 500,
                //             ),
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text("وصول العمالة", style: TextStyle(fontWeight: AppConstants.bold,
                //                       fontSize: 25,
                //                       color: Colors.white),),
                //                 ),
                //                 Spacer(),
                //                 Icon(Icons.groups , color: Colors.white,),
                //
                //                 SizedBox(width: 10,)
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     back: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey1.currentState?.toggleCard(),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Image.network("https://robuashaqraa.com/frontend/img/logo/roboo3Logo.png"
                //               , fit: BoxFit.cover,
                //
                //               height: 100,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("وصول العمالة", style: TextStyle(fontWeight: AppConstants.bold,
                //                   fontSize: 25,
                //                   color: AppColors.secondaryColor),),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(" وصول العمالة المنزلية من المطار المحلي الى المكتب ",
                //                 style: TextStyle(fontWeight: AppConstants.bold,
                //                     fontSize: 15,
                //                     color: Colors.grey),),
                //             ),
                //
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(width: 10,),
                //   FlipCard(
                //     key: cardKey3,
                //     flipOnTouch: false,
                //     front: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey3.currentState?.toggleCard(),
                //         child: Stack(
                //           alignment: Alignment.bottomRight,
                //           children: [
                //             Image.asset("assets/images/home/service3.webp", fit: BoxFit.cover,
                //               height: 500,
                //             ),
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text("تعاقد الاستقدام", style: TextStyle(fontWeight: AppConstants.bold,
                //                       fontSize: 25,
                //                       color: Colors.white),),
                //                 ),
                //                 Spacer(),
                //                 Icon(Icons.pin_end , color: Colors.white,),
                //                 SizedBox(width: 10,)
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     back: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey3.currentState?.toggleCard(),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Image.network("https://robuashaqraa.com/frontend/img/logo/roboo3Logo.png"
                //               , fit: BoxFit.cover,
                //
                //               height: 100,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("تعاقد الاستقدام", style: TextStyle(fontWeight: AppConstants.bold,
                //                   fontSize: 25,
                //                   color: AppColors.secondaryColor),),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("  دفع رسوم الاستقدام عبر التعاقد في برنامج مساند  ",
                //                 style: TextStyle(fontWeight: AppConstants.bold,
                //                     fontSize: 15,
                //                     color: Colors.grey),),
                //             ),
                //
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(width: 10,),
                //   FlipCard(
                //     key: cardKey4,
                //     flipOnTouch: false,
                //     front: Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey4.currentState?.toggleCard(),
                //         child: Stack(
                //           alignment: Alignment.bottomRight,
                //           children: [
                //             Image.asset("assets/images/home/service4.webp", fit: BoxFit.cover,
                //               height: 500,
                //             ),
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text("اختيار العمالة", style: TextStyle(fontWeight: AppConstants.bold,
                //                       fontSize: 25,
                //                       color: Colors.white),),
                //                 ),
                //                 Spacer(),
                //                 Icon(Icons.shopping_bag , color: Colors.white,),
                //                 SizedBox(width: 10,)
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     back:Container(
                //
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //
                //       ),
                //       child: MaterialButton(
                //         onPressed: () => cardKey4.currentState?.toggleCard(),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Image.network("https://robuashaqraa.com/frontend/img/logo/roboo3Logo.png"
                //               , fit: BoxFit.cover,
                //
                //               height: 100,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("اختيار العمالة", style: TextStyle(fontWeight: AppConstants.bold,
                //                   fontSize: 25,
                //                   color: AppColors.secondaryColor),),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(" اختيار السيره الذاتيه للعماله المنزليه عبر البحث في",
                //                 style: TextStyle(fontWeight: AppConstants.bold,
                //                     fontSize: 15,
                //                     color: Colors.grey),),
                //             ),
                //
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
              ),
            )

          ],
        );
    }),
  );
}

buildOurOffers(context) {
  RequestsController requestsController = Get.find<RequestsController>();

  requestsController.getCvs();
  HomeController controller = Get.find();
  return ShowUp(
    delay: 400,
    child:


    Obx(() {

      return
        controller.isCountriesLoading.value ? SizedBox() :
        Column(
        children: [
          SizedBox(height: 30,),
          Text("عروضنا غير", style: TextStyle(
              fontWeight: AppConstants.bold, color: Color(0xffD4AF37),
              fontSize: 20
          )),
          SizedBox(height: 10,),

          Text(" يمكنك اختيار الدولة التى تتم عملية الاستقدام منها ",
            style: TextStyle(
                fontWeight: FontWeight.w300, color: Color(0xffD4AF37),
                fontSize: 15
            ),),
          SizedBox(height: 10,),
          Container(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  _buildOfferCard(
                      context: context,
                      data: controller.countries.value.data[index]),
              separatorBuilder: (context, index) => SizedBox(width: 20,),
              itemCount: controller.countries.value.data.length,),
          ),
          SizedBox(height: 10,),
        ],
      );
    }).animate().slideX(duration: 500.ms).fadeIn(duration: 200.ms),
  );
}

_buildOfferCard({required BuildContext context, required CountryData data}) {
  RequestsController requestsController = Get.find<RequestsController>();
  return Container(
      height: 220,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffF3EEE4),
      ),
      child: Column(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: CachedNetworkImageProvider(
                      data.image!
                  ),


                ),


                SizedBox(height: 20,),
                Text(data.title!, style:
                TextStyle(fontWeight:
                AppConstants.semiBold, color:
                AppColors.secondaryColor,
                    fontSize: 20
                ),),
                SizedBox(height: 10,),
                Text(data.description!,
                  textAlign: TextAlign.center,
                  style:
                TextStyle(fontWeight:
                FontWeight.w500, color:
                Colors.grey,
                    fontSize: 11
                ),),
                SizedBox(height: 10,),
                Text(data.recruitmentPrice.toString(), style:
                TextStyle(fontWeight:
                FontWeight.w500, color:
                Colors.black,
                    fontSize: 13
                ),),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    // Handle Option 1
                    requestsController.clearAllOrderDetails();
                    Get.to(() => RequestsView(title: 'استقدام',));
                    requestsController.type.value = 'admission';

                    requestsController.nationality.value = data.title!;

                    requestsController.getCvs();


                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('اطلب الان', style:
                      TextStyle(fontWeight:
                      FontWeight.w400, color:
                      AppColors.secondaryColor,
                          fontSize: 13
                      ),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_forward, color: AppColors.secondaryColor,)
                    ],
                  ),
                )

              ]),
        ],
      ));
}