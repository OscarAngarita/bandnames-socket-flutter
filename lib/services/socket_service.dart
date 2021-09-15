import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;


  SocketService() {
    _initConfig();
  }

  void _initConfig() {

    // Dart client
    IO.Socket socket = IO.io('http://192.168.0.10:3000/', {
      'transports': ['websocket'],
      'autoConnect': true

    });
    print('hey');
    socket.onConnect((_) {
      print('connect');
    });


    socket.on('disconnect', (_) => print('disconnect'));

    // socket.connect();
  }
}