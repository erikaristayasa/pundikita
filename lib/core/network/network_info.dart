import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementaion implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImplementaion({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
