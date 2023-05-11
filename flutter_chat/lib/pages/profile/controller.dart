import 'dart:convert';

import 'package:flutter_chat/common/entities/entities.dart';
import 'package:flutter_chat/common/routes/names.dart';
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

  Future<void> onLogOut() async {
    UserStore.to.onLogout();
    await _googleSignIn.signOut();
    Get.offAndToNamed(AppRoutes.singIn);
  }

  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();
    List MyList = [
      {
        "name": "Conta",
        "icon": "assets/icons/1.png",
        "route": "/account",
      },
      {
        "name": "Chat",
        "icon": "assets/icons/2.png",
        "route": "/chat",
      },
      {
        "name": "Notificação",
        "icon": "assets/icons/3.png",
        "route": "/notification"
      },
      {
        "name": "Privacidade",
        "icon": "assets/icons/4.png",
        "route": "/privacy",
      },
      {
        "name": "Ajuda",
        "icon": "assets/icons/5.png",
        "route": "/help",
      },
      {
        "name": "Sobre",
        "icon": "assets/icons/6.png",
        "route": "/about",
      },
      {
        "name": "Sair",
        "icon": "assets/icons/7.png",
        "route": "/logout",
      },
    ];

    for (var i = 0; i < MyList.length; i++) {
      MeListItem result = MeListItem();
      result.icon = MyList[i]['icon'];
      result.name = MyList[i]['name'];
      result.route = MyList[i]['route'];
      state.meListItem.add(result);
    }
  }
}
