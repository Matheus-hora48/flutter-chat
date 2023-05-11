import 'package:flutter_chat/pages/message/photoview/state.dart';
import 'package:get/get.dart';

class PhotoImageViewController extends GetxController {
  PhotoImageViewController();
  final PhotoImageViewState state = PhotoImageViewState();

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    if (data['url']!= null) {
      state.url.value = data['url']!;
    }
  }
}
