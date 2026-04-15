import 'dart:io';

/// Abstraction for checking connectivity.
abstract class NetworkInfo {
  /// Returns true when internet or network transport is available.
  Future<bool> get isConnected;
}

/// [NetworkInfo] implementation using [dart:io].
class NetworkInfoImpl implements NetworkInfo {
  /// Creates [NetworkInfoImpl].
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}

