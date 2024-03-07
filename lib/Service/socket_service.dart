import 'dart:developer';
import 'package:drivy_driver/Service/socket_navigation_class.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'api_endpoints.dart';

class SocketService {
  static Socket? _socket;
  SocketService._();
  static SocketService? _instance;
  static SocketService? get instance {
    if (_instance == null) {
      _instance = SocketService._();
    }
    return _instance;
  }
  Socket? get socket => _socket;
  void initializeSocket() {
    _socket = io(APIEndpoints.socketBaseURL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
  }
  void connectSocket() {
    // _socket = io(NetworkStrings.SOCKET_API_BASE_URL, <String, dynamic>{
    //   'autoConnect': false,
    //   'transports': ['websocket'],
    // });
    _socket?.connect();
    _socket?.on("connect", (data) {
      log('Connected socket ');
      // CustomToast().showToast("Success", "Chat Connected",false);
      // checkSocketConnection(true);
    });
    _socket?.on("disconnect", (data) {
      log('Disconnected ' + data.toString());
      // CustomToast().showToast("Success", "Chat Disconnected",false);
    });
    _socket?.on("connect_error", (data) {
      log('Connect Error ' + data.toString());
    });
    _socket?.on("error", (data) {
      log('Error ' + data.toString());
      SocketNavigationClass.instance?.socketErrorMethod(errorResponseData: data);
    });
    //log("Socket Connect:${socket?.connected}");
  }
  void socketEmitMethod(
      {required String eventName, required dynamic eventParamaters}) {
    _socket?.emit(eventName, eventParamaters);
  }
  void socketResponseMethod() {
    _socket?.on("response", (data) {
      //log("response data ha:$data");
      SocketNavigationClass.instance?.socketResponseMethod(r: data);
    });
  }
  void dispose() {
    _socket?.dispose();
  }
}