import 'dart:io';

enum NetworkType { none, wifi, mobile, vpn }

class NetworkUtil {
  Future<bool> isNetworkAvailabel() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  NetworkType getNetworkType() {
    return NetworkType.wifi;
  }

  ///Singleton factory
  static final NetworkUtil _instance = NetworkUtil._internal();

  factory NetworkUtil() {
    return _instance;
  }

  NetworkUtil._internal();
}
