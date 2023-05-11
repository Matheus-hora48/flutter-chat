import 'package:flutter/material.dart';
import 'package:flutter_chat/common/values/colors.dart';
import 'package:flutter_chat/pages/application/index.dart';
import 'package:flutter_chat/pages/contact/index.dart';
import 'package:flutter_chat/pages/message/view.dart';
import 'package:flutter_chat/pages/profile/view.dart';
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
        children: const [
          MessagePage(),
          ContactPage(),
          ProfilePage(),
        ],
      );
    }

    Widget _buildBottomNavigationBar() {
      return Obx(
        () => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTap,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: AppColors.tabBarElement,
          selectedItemColor: AppColors.thirdElement,
        ),
      );
    }

    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
