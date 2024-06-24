
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkIChecker {
  Future<bool> get isConnected;
}

class NetworkCheckerImpl implements NetworkIChecker {
  final Connectivity connectivity;

  NetworkCheckerImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
