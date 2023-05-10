import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/entities.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget chatLeftItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 230.w,
            maxHeight: 40.w,
          ),
          child: Container(
            margin: EdgeInsets.only(right: 10.w, bottom: 0.w),
            padding: EdgeInsets.all(10.w),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 176, 106, 231),
                  Color.fromARGB(255, 166, 112, 231),
                  Color.fromARGB(255, 136, 123, 231),
                  Color.fromARGB(255, 104, 132, 231),
                ],
                transform: GradientRotation(90),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: item.type == "text"
                ? Text("${item.content}")
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 90.w,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: CachedNetworkImage(
                        imageUrl: "${item.content}",
                      ),
                    ),
                  ),
          ),
        )
      ],
    ),
  );
}
