import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;

  Function get emit => this._socket.emit;


  SocketService() {
    _initConfig();
  }

  void _initConfig() {

    // Dart client
    this._socket = IO.io('http://192.168.0.3:3000/', {
      'transports': ['websocket'],
      'autoConnect': true

    });
    
    this._socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    
    this._socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // this._socket.on('nuevo-mensaje', (payload) {
    //   // print('nuevo-mensaje: $payload');
    //   print('nuevo-mensaje:');
    //   if (payload['nombre'] != null) print('nombre: ' + payload['nombre']);  //Forma 1 de evaluar nulo
    //   print('mensaje: ' + (payload['mensaje'] ?? '')); //Forma 2 de evaluar nulo
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No hay'); //Forma 3 de evaluar nulo
    // });

    // socket.connect();
  }
}