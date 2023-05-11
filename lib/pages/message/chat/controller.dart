import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat/common/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/common/entities/entities.dart';
import 'package:flutter_chat/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'index.dart';
import 'package:path/path.dart';

import 'package:get/get.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();

  var doc_id = null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contextNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('Não foi selecionada nenhuma imagem');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('Não foi selecionada nenhuma imagem');
    }
  }

  Future getImgUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  sendImageMessage(String url) async {
    final content = Msgcontent(
      uid: user_id,
      content: url,
      type: "image",
      addtime: Timestamp.now(),
    );
    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgcontent, options) =>
                msgcontent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(doc_id).update({
      "last_msg": "[image]",
      "last_time": Timestamp.now(),
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final filename = getRandomString(15) + extension(_photo!.path);
    try {
      final ref = FirebaseStorage.instance.ref("chat").child(filename);
      await ref.putFile(_photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;

          case TaskState.paused:
            break;

          case TaskState.success:
            String imgUrl = await getImgUrl(filename);
            sendImageMessage(imgUrl);
            break;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'];
    state.to_uid.value = data['to_id'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
  }

  sendMessage() async {
    String sendContent = textController.text;
    if (sendContent.isNotEmpty) {
      final content = Msgcontent(
        uid: user_id,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now(),
      );
      await db
          .collection("message")
          .doc(doc_id)
          .collection("msglist")
          .withConverter(
              fromFirestore: Msgcontent.fromFirestore,
              toFirestore: (Msgcontent msgcontent, options) =>
                  msgcontent.toFirestore())
          .add(content)
          .then((DocumentReference doc) {
        textController.clear();
        Get.focusScope?.unfocus();
      });
      await db.collection("message").doc(doc_id).update({
        "last_msg": sendContent,
        "last_time": Timestamp.now(),
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
    var message = db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .orderBy(
          "addtime",
          descending: false,
        );
    state.msgcontentlist.clear();
    listener = message.snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data() != null) {
              state.msgcontentlist.insert(0, change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
          default:
        }
      }
    }, onError: (error) => print("Falha: $error"));
    getLocation();
  }

  getLocation() async {
    try {
      var user_location = await db
          .collection("users")
          .where("id", isEqualTo: state.to_uid.value)
          .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore(),
          )
          .get();
      var location = user_location.docs.first.data().location;
      if (location != "") {
        state.to_location.value = location ?? "Sem localição";
      }
    } catch (e) {
      print('Tem um erro no getLocation: $e');
    }
  }

  @override
  void disponse() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
