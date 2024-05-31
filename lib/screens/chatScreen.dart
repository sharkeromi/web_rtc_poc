import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_poc_2/controllers/homeController.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: homeController.messages.length,
                    itemBuilder: (context, index) {
                      var item = homeController.messages[index];
                      return BubbleNormal(
                        text: item["message"],
                        isSender: item["userType"] != "self" ? false : true,
                        color: item["userType"] != "self" ? Color(0xFF1B97F3) : Colors.white70,
                        tail: false,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: item["userType"] != "self" ? Colors.white : Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            MessageBar(
              onSend: (val) {
                homeController.send(val);
              },
              actions: [
                InkWell(
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.green,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
