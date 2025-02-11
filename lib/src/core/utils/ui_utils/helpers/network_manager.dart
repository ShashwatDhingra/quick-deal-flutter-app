import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends StateNotifier<ConnectivityResult> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  NetworkManager() : super(ConnectivityResult.none) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update the connection status based on changes in connectivity.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    state = result;
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}

/// Provider for the NetworkManager.
final networkManagerProvider =
    StateNotifierProvider<NetworkManager, ConnectivityResult>((ref) {
  return NetworkManager();
});


    // use the network manager
  //  final connectivityStatus = ref.watch(networkManagerProvider);

  //   // Check if there's no internet connection and show a warning.
  //   if (connectivityStatus == ConnectivityResult.none) {
  //     TLoaders.warningSnackBar(
  //       title: 'No Internet Connection',
  //       context: context,
  //     );
  //   }