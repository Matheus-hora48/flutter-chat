import 'package:flutter_chat/common/entities/entities.dart';
import 'package:flutter_chat/common/entities/msg.dart';
import 'package:flutter_chat/common/store/user.dart';
import 'package:flutter_chat/common/utils/http.dart';
import 'package:flutter_chat/pages/message/state.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageController extends GetxController {
  MessageController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  final MessageState state = MessageState();
  var listener;

  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  void onRefresh() {
    asyncLoadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchErro((_) {
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    asyncLoadAllData().then((_) {
      refreshController.loadComplete();
    }).catchErro((_) {
      refreshController.loadFailed();
    });
  }

  asyncLoadAllData() async {
    var from_message = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where(
          "from_uid",
          isEqualTo: token,
        )
        .get();

    var to_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where(
          "to_uid",
          isEqualTo: token,
        )
        .get();

    state.msgList.clear();
    if (from_message.docs.isNotEmpty) {
      state.msgList.assignAll(from_message.docs);
    }
    if (to_messages.docs.isNotEmpty) {
      state.msgList.assignAll(to_messages.docs);
    }
  }

  getUserLocation() async {
    try {
      final location = await Location().getLocation();
      String address = "${location.latitude}, ${location.longitude}";
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?address=${address}&key=AIzaSyBGLUxRYJgu8Q1PuVVHKXwBVGAILiqchhQ";
      var response = await HttpUtil().get(url);
      MyLocation location_res = MyLocation.fromJson(response);
      if (location_res.status == "OK") {
        String? myadress = location_res.results?.first.formattedAddress;
        if (myadress != null) {
          var userLocation = await db.collection("users").where("id", isEqualTo: token);
              
          if (userLocation.docs.isNotEmpty) {
            var doc_id = user_location.docs.first.id;
            await
          }
        }
      }
    } catch (e) {
      print('Localização erro: $e');
    }
  }
}
