import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/entities.dart';
import 'package:get/get.dart';

class ProfileState {
  var head_detail = Rx<UserLoginResponseEntity?>(null);
  RxList<MeListItem> meListItem = <MeListItem>[].obs;
}