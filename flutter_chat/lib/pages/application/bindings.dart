import 'package:flutter_chat/pages/message/messagecontroller.dart';
import 'package:get/get.dart';
import '../contact/index.dart';
import 'index.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(
      () => ApplicationController(),
    );
    Get.lazyPut<ContactController>(
      () => ContactController(),
    );
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );
  }
}
