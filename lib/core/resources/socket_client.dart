import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  static final instance = SocketClient._internal();

  static Socket? _socket;

  SocketClient._internal();

  Socket _initializeSocket() {
    final socket = io(
      const String.fromEnvironment('serverUrl'),
      OptionBuilder().setTransports(['websocket']).build(),
    );
    return socket.connect();
  }

  Socket get socket {
    if (_socket != null) return _socket!;
    _socket = _initializeSocket();
    return _socket!;
  }

  void dispose() {
    if (_socket == null) return;
    _socket!.dispose();
    _socket = null;
  }
}
