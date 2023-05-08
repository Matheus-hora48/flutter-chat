import 'package:flutter/material.dart';
import 'package:flutter_chat/common/middlewares/middlewares.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/pages/welcome/index.dart';
import 'package:flutter_chat/pages/auth/index.dart';
import 'package:get/get.dart';

import '../../pages/application/index.dart';

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
    ),
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
          //RouteAuthMiddleware(priority: 1)
        ]),
  ];
}
