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
