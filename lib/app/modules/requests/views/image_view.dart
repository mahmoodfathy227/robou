import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends GetView {
  const ImageView(this.imgPath, {super.key});
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('عرض الصورة'),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          tag: imgPath,
          child: PhotoView(

            imageProvider: NetworkImage(imgPath) ,),
        )

      ),
    );
  }
}
