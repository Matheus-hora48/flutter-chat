import 'dart:convert';

import 'package:flutter_chat/common/entities/entities.dart';
import 'package:flutter_chat/common/entities/user.dart';
import 'package:flutter_chat/common/routes/routes.dart';
import 'package:flutter_chat/common/store/store.dart';
import 'package:flutter_chat/pages/contact/state.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactController extends GetxController {
  ContactController();
  final ContactState state = ContactState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData to_userdata) async {
    var from_messages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: to_userdata.id)
        .get();

    var to_messages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: to_userdata.id)
        .where("to_uid", isEqualTo: token)
        .get();

    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userdata = UserLoginResponseEntity.fromJson(
        jsonDecode(profile),
      );
      var msgdata = Msg(
        from_uid: userdata.accessToken,
        to_uid: to_userdata.id,
        from_name: userdata.displayName,
        to_name: to_userdata.name,
        from_avatar: userdata.photoUrl,
        to_avatar: to_userdata.photourl,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      db
          .collection("message")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(msgdata)
          .then((value) => {
                Get.toNamed("/chat", parameters: {
                  "doc_id": value.id,
                  "to_uid": to_userdata.id ?? "",
                  "to_name": to_userdata.name ?? "",
                  "to_avatar": to_userdata.photourl ?? "",
                })
              });
    } else {
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed(
          AppRoutes.chat,
          parameters: {
            "doc_id": from_messages.docs.first.id,
            "to_uid": to_userdata.id ?? "",
            "to_name": to_userdata.name ?? "",
            "to_avatar": to_userdata.photourl ?? "",
          },
        );
      }
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed(
          "/chat",
          parameters: {
            "doc_id": to_messages.docs.first.id,
            "to_uid": to_userdata.id ?? "",
            "to_name": to_userdata.name ?? "",
            "to_avatar": to_userdata.photourl ?? "",
          },
        );
      }
    }
  }

  asyncLoadAllData() async {
    var usersbase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata, options) => userdata.toFirestore(),
        )
        .get();

    for (var doc in usersbase.docs) {
      state.contactList.add(doc.data());
    }
  }
}
