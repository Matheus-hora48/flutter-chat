import 'package:flutter_chat/common/routes/names.dart';
import 'package:flutter_chat/common/store/config.dart';
import 'package:flutter_chat/pages/welcome/state.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WelcomeController extends GetxController{
  final state = WelcomeState();
  WelcomeController();

  changePage(int index) async{
    state.index.value = index;
  }

  handleSingIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.singIn);
  }
}