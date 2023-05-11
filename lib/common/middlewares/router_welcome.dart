import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/store/config.dart';
import 'package:flutter_chat/common/store/user.dart';

import 'package:get/get.dart';

/// 第一次欢迎页面
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    print(ConfigStore.to.isFirstOpen);
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return RouteSettings(name: AppRoutes.application);
    } else {
      return RouteSettings(name: AppRoutes.singIn);
    }
  }
}
