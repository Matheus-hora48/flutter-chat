import 'package:get/get.dart';
import 'index.dart';

class SingInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingInController>(
      () => SingInController(),
    );
  }
}
