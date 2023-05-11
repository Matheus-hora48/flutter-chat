import 'package:flutter/material.dart';
import 'package:flutter_chat/common/values/colors.dart';
import 'package:flutter_chat/pages/message/photoview/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoImageView extends GetView<PhotoImageViewController> {
  const PhotoImageView({super.key});

  AppBar _buildAppbar() {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.w),
        child: Container(
          color: AppColors.secondaryElement,
          height: 2.w,
        ),
      ),
      title: const Text(
        "Foto",
        style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.normal),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 176, 106, 231),
            Color.fromARGB(255, 166, 112, 232),
            Color.fromARGB(255, 131, 123, 232),
            Color.fromARGB(255, 104, 132, 231),
          ], transform: GradientRotation(90)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(controller.state.url.value),
        ),
      ),
    );
  }
}
