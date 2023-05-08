import 'package:flutter_chat/pages/welcome/controller.dart';
import 'package:get/get.dart';

import 'index.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(
      () => ContactController(),
    );
  }
}
