import 'package:flutter_chat/common/entities/entities.dart';
import 'package:get/state_manager.dart';

class ChatState {
  RxList<Msgcontent> Msgcontentlist = <Msgcontent>[].obs;
  var to_uid = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var to_location = "unknown".obs;
}