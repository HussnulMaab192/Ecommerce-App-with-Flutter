import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/chatController.dart';
import 'package:flutter_amazon/services/firestore.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:get/get.dart';

import 'components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: controller.friendName
            .toString()
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    )
                  : Expanded(
                      child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "send a message..."
                                .text
                                .color(darkFontGrey)
                                .make(),
                          );
                        } else {
                          return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                            var data = snapshot.data!.docs[index];
                            return Align(
                                alignment: data['uId'] == currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: senderBubble(data));
                          }).toList());
                        }
                      },
                    )),
            ),
            myCommonheight(0.01),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: textfieldGrey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                      maxLines: null, // Allow multiple lines of text
                      decoration: const InputDecoration(
                        hintText: "Type a message ....",
                        border: InputBorder.none, // Remove the border
                        isCollapsed:
                            true, // Allow the text field to expand vertically
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.sendMessage(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send),
                    color: redColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
