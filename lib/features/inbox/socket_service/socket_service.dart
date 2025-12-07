import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      "http://localhost:5001", // change if deployed
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          // .setQuery({"userId": })
          .build(),
    );

    socket.connect();

    socket.onConnect((_) => print("✅ Connected to socket server"));
    socket.onDisconnect((_) => print("❌ Disconnected from socket server"));
  }

  void joinChat(String chatId) {
    socket.emit("join_chat", chatId);
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void disconnect() {
    socket.disconnect();
  }
}
