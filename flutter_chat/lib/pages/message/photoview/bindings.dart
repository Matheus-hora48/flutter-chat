import 'package:get/get.dart';

import 'index.dart';

class PhotoImageViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoImageViewController>(
      () => PhotoImageViewController(),
    );
  }
}
