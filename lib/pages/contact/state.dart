import 'package:flutter_chat/common/entities/user.dart';
import 'package:get/state_manager.dart';

class ContactState {
  var count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}