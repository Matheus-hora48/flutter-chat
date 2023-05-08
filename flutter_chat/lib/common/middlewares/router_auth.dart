import 'package:flutter/material.dart';
import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/store/user.dart';

import 'package:get/get.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.singIn ||
        route == AppRoutes.initial) {
      return null;
    } else {
      Future.delayed(const Duration(seconds: 1),
          () => Get.snackbar("Dica", "Login expirado, faça login novamente"));
      return const RouteSettings(name: AppRoutes.singIn);
    }
  }
}
