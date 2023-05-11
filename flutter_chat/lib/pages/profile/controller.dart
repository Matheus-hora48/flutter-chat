import 'dart:convert';

import 'package:flutter_chat/common/entities/entities.dart';
import 'package:flutter_chat/common/store/user.dart';
import 'package:flutter_chat/pages/profile/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  final ProfileState state = ProfileState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]);

  asyncLoadAllData() async {
    String profile = await UserStore.to.getProfile();
    if (!profile.isEmpty) {
      UserLoginResponseEntity userdata = UserLoginResponseEntity.fromJson(
        jsonDecode(profile),
      );
      state.head_detail.value = userdata;
    }
  }
  
  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();
  }
}
