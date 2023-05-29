import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/home_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getchatId();
  }

  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().userName;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;
  var isLoading = false.obs;
  getchatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMessage(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      chats.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        '_msg': msg,
        'uId': currentId,
      });
    }
  }
}
