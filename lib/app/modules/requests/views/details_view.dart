import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:robua/app/modules/customerServiceLogin/controllers/customer_service_login_controller.dart';
import 'package:robua/app/modules/global/models/models.dart';
import 'package:robua/app/modules/requests/views/order_view.dart';
import 'package:robua/app/modules/requests/views/video_view.dart';
import 'package:video_player/video_player.dart';

import '../../../data/colors.dart';
import '../controllers/requests_controller.dart';
import 'image_view.dart';

class DetailsView extends GetView<RequestsController> {

  const DetailsView(this.element, this.isCustomerService, this.orderId,
      this.orderStatus, {Key? key}) : super(key: key);
  final CvElement element;
  final bool isCustomerService;
  final int? orderId;
  final String? orderStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفاصيل السيرة الذاتية")),
      body:
      Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery
                  .of(context)
                  .size
                  .height / 1.5,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,

                background: Hero(
                  tag: element.image!,
                  child:
                  GestureDetector(
                    onTap: () {
                      print("tapped");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImageView(element.image!)));
                    },
                    child:
                    isCustomerService ?
                    Stack(
                      children: [
                        CachedNetworkImage(
                            imageUrl: element.image!,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
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
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              orderStatus ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        :
                    CachedNetworkImage(
                        imageUrl: element.image!,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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


                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'التفاصيل',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("العمر : ${element.age}"),

                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text("الراتب : ${element.salary}"),

                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.work),
                          title: Text("المهنة : ${element.job}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.safety_divider),
                          title: Text("الحالة : ${element.status}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.motion_photos_on_outlined),
                          title: Text("الديانة : ${element.religion}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.language_rounded),
                          title: Text("اللغة: ${element.spokenLanguage}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.group),
                          title: Text(
                              "الحالة الإجتماعية: ${element.socialType}"),
                        ),
                        SizedBox(height: 16.0),

                        ListTile(
                          leading: Icon(Icons.padding_rounded),
                          title: Text("رقم الباسبور : ${element.passportNo}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text("الخبرة : ${element.experience}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.person_search),
                          title: Text("الجنسية: ${element.nationality}"),
                        ),
                        SizedBox(height: 16.0),
                        ListTile(
                          leading: Icon(Icons.video_call),
                          title: Row(
                            children: [
                              Text("الفيديو"),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        VideoPlayerView(url: element.video!,
                                          dataSourceType: DataSourceType
                                              .network,
                                        ));
                                  },
                                  child: Icon(Icons.launch)),
                            ],
                          ),
                        ),
                        SizedBox(height: 70,)
                        // Add more product details as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !isCustomerService ? SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width / 2,
          child: FloatingActionButton(
            heroTag: 'order',
            onPressed: () {
              // Handle button press
            },
            backgroundColor: AppColors.secondaryColor,
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),

                onPressed: () {
                  //setting rent or not
                  //will be handled accroding to the type variable

                  //sending cv id
                  controller.setCvId(element.id!);


                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderView()));
                },
                child: Text('احجز الأن', style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),


              ),
            ),
          ),
        )
            :
        CustomFloatingActionButton(orderId!)
        ,
      ),);
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton(this.elementId);

  final int elementId;

  CustomerServiceLoginController controller = Get.find<
      CustomerServiceLoginController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      // Adjust the margin as needed
      child: Obx(() {
        return
          controller.isUpdatingOrderStatus.value?
              SpinKitThreeInOut(
                color: AppColors.secondaryColor,
              )
          :
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                // Handle delete action
                await controller.updateOrderStatus(elementId, true);
                print('Delete button pressed');
              },
              child: Icon(Icons.delete),
              backgroundColor: Colors.red,
            ),
            SizedBox(width: 16), // Space between buttons
            FloatingActionButton(
              onPressed: () async {
                // Handle edit action
                await controller.updateOrderStatus(elementId, false);
                print('Edit button pressed');
              },
              child: Icon(Icons.edit),
              backgroundColor: Colors.blue,
            ),
          ],
        );
      }),
    );
  }
}