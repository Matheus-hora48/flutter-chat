import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/values/colors.dart';
import 'package:flutter_chat/common/values/shadows.dart';
import 'package:flutter_chat/common/widgets/widgets.dart';
import 'package:flutter_chat/pages/application/index.dart';
import 'package:flutter_chat/pages/auth/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildPageView() {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: [
          Container(
            child: const Center(
              child: Text('Conversas'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('Contatos'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('Perfil'),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: _buildPageView(),
    );
  }
}
