import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peerdart/peerdart.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  final Peer peer = Peer(options: PeerOptions(debug: LogLevel.All));
  final TextEditingController txtController = TextEditingController();
  final RxString peerId = RxString("");
  late DataConnection conn;
  final RxBool connected = RxBool(false);
  final RxList<Map<String, dynamic>> messages = RxList([]);

  @override
  void onInit() {
    peer.on("open").listen((id) {
      peerId.value = peer.id!;
      if (peerId.value != "") {
        socketConnect(peerId.value);
      }
    });

    peer.on("close").listen((id) {
      connected.value = false;
    });

    peer.on<DataConnection>("connection").listen((event) {
      conn = event;
      conn.on("data").listen((data) {
        log("test: ${conn.peer}");
        messages.add({"userType": "sender", "message": data});
        log("data: $data");
      });

      conn.on("binary").listen((data) {
        log("binary: $data");
      });

      conn.on("close").listen((event) {
        connected.value = false;
      });

      connected.value = true;
    });
    super.onInit();
  }

  void socketConnect(peerID) {
    log("Connecting...");

    IO.Socket socket = IO.io('wss://node.biphip.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      log('Connected: ${socket.id}');
      socket.emit("mobile-chat-channel", peerID);
    });

    socket.on('mobile-chat-channel', (data) {
      log('Received peer ID: $data');
      addPeerID(data);
    });

    socket.on('peerRequestIncoming', (data) {
      log('peerRequestIncoming: $data');
    });

    socket.on('messageResponse', (data) {
      log('messageResponse: $data');
    });

    socket.on('disconnect', (_) {
      log('Disconnected');
    });

    socket.on('error', (error) {
      log('Socket error: $error');
    });
  }

  void connectToPeer(peerId) {
    try {
      final connection = peer.connect(peerId);
      log(connection.connectionId);
      conn = connection;

      conn.on("open").listen((event) {
        connected.value = true;
        connection.on("close").listen((event) {
          connected.value = false;
        });

        conn.on("data").listen((data) {
          messages.add({"userType": "sender", "message": data});
          log("test: ${conn.peer}");
        });
        conn.on("binary").listen((data) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("Got binary!")));
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void send(message) {
    messages.add({"userType": "self", "message": message});
    conn.send(message);
  }

  RxList peerList = RxList([]);
  void addPeerID(data) {
    peerList.add(data);
  }

  @override
  void onClose() {
    peer.dispose();
    super.onClose();
  }
}
