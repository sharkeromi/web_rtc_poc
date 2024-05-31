import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_poc_2/controllers/homeController.dart';
import 'package:web_rtc_poc_2/routes.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    log(homeController.peerId.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Obx(() => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Obx(() => Text(homeController.connected.value ? "Connected" : "Standby")),
                  const Text(
                    'Connection ID:',
                  ),
                  SelectableText(homeController.peerId.value),
                  TextField(
                    controller: homeController.txtController,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // homeController.connectToPeer();
                      },
                      child: const Text("connect")),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(krChat);
                      },
                      child: const Text("Chat")),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeController.peerList.length,
                      itemBuilder: (context, index) {
                        var item = homeController.peerList[index];
                        return ListTile(
                          title: Text("User ${index + 1}"),
                          subtitle: Text(item),
                          onTap: () {
                            homeController.connectToPeer(item);
                            Get.toNamed(krChat);
                          },
                        );
                      })
                ],
              ),
            ),
          )),
    );
  }
}
