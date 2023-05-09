import 'package:flutter/material.dart';
import 'package:flutter_chat/common/style/style.dart';
import 'package:flutter_chat/common/values/colors.dart';
import 'package:flutter_chat/pages/application/index.dart';
import 'package:flutter_chat/pages/contact/index.dart';
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
          const ContactPage(),
          Container(
            child: const Center(
              child: Text('Perfil'),
            ),
          ),
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
