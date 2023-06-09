import 'package:flutter/material.dart';
import 'package:flutter_chat/common/middlewares/middlewares.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/pages/message/photoview/index.dart';
import 'package:flutter_chat/pages/profile/view.dart';
import 'package:get/get.dart';

import '../../pages/application/index.dart';
import '../../pages/contact/index.dart';
import '../../pages/auth/index.dart';
import '../../pages/profile/index.dart';
import '../../pages/welcome/index.dart';
import '../../pages/message/chat/index.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static const application = AppRoutes.application;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.initial,
        page: () => const WelcomePage(),
        binding: WelcomeBinding(),
        middlewares: [
          RouteWelcomeMiddleware(priority: 1),
        ]),
    GetPage(
      name: AppRoutes.singIn,
      page: () => const SingInPage(),
      binding: SingInBinding(),
    ),
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.photoImgView,
      page: () => const PhotoImageView(),
      binding: PhotoImageViewBinding(),
    ),
    GetPage(
      name: AppRoutes.me,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
