import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/values/colors.dart';
import 'package:flutter_chat/common/values/shadows.dart';
import 'package:flutter_chat/common/widgets/widgets.dart';
import 'package:flutter_chat/pages/message/chat/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 176, 106, 231),
            Color.fromARGB(255, 166, 112, 231),
            Color.fromARGB(255, 136, 123, 231),
            Color.fromARGB(255, 104, 132, 231),
          ], transform: GradientRotation(90)),
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              child: InkWell(
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: CachedNetworkImage(
                    imageUrl: controller.state.to_avatar.value,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 44.w,
                      height: 44.w,
                      margin: null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(44.w),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (contex, url, error) => const Image(
                      image: AssetImage('assets/images/feature-1.png'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Container(
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              width: 180.w,
              child: Row(
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 44.w,
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.state.to_name.value,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBackground,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            'Localização desconhecida',
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryBackground,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              Positioned(
                bottom: 0.h,
                height: 50.h,
                child: Container(
                  width: 360.w,
                  height: 50.w,
                  color: AppColors.primaryBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 217.w,
                        height: 50.h,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: controller.textController,
                          autofocus: false,
                          focusNode: controller.contextNode,
                          decoration: const InputDecoration(
                            hintText: "Enviar mensagem..",
                          ),
                        ),
                      ),
                      Container(
                        height: 30.h,
                        width: 30.h,
                        margin: EdgeInsets.only(left: 5.w),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.photo_camera_outlined,
                            size: 35,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        height: 30.h,
                        width: 30.h,
                        margin: EdgeInsets.only(left: 5.w),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.send_rounded,
                            size: 35,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            controller.sendMessage();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
