import 'package:flutter_chat/common/entities/user.dart';
import 'package:flutter_chat/common/routes/routes.dart';
import 'package:flutter_chat/common/store/store.dart';
import 'package:flutter_chat/common/widgets/widgets.dart';
import 'package:flutter_chat/pages/auth/index.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn _googleSingIn = GoogleSignIn(scopes: <String>[
  'openid',
]);

class SingInController extends GetxController {
  final state = SingInState();
  SingInController();
  final db = FirebaseFirestore.instance;
  Future<void> handleSingIn() async {
    try {
      var user = await _googleSingIn.signIn();
      if (user != null) {
        final _gAuthentication = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gAuthentication.idToken,
            accessToken: _gAuthentication.accessToken);

        await FirebaseAuth.instance.signInWithCredential(_credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);
        var userbase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userdata, options) =>
                  userdata.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();
        if (userbase.docs.isEmpty) {
          final date = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: "",
            fcmtoken: "",
            addtime: Timestamp.now(),
          );
          await db
              .collection("users")
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userdata, options) =>
                    userdata.toFirestore(),
              )
              .add(date);
        }
        toastInfo(msg: "Login foi feito com sucesso!");
        Get.offAndToNamed(AppRoutes.application);
      }
    } catch (e) {
      toastInfo(msg: "Erro ao entrar: $e");
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("usuário desconectado");
      } else {
        print("o usuário está logado");
      }
    });
  }
}
