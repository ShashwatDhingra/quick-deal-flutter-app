import 'package:flutter/material.dart';

class LoadingManager {
  static final LoadingManager _instance = LoadingManager._internal();

  factory LoadingManager() => _instance;

  LoadingManager._internal();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  OverlayEntry? _overlayEntry;

  void showLoading() {
    if (_overlayEntry != null) return; // Prevent duplicate loaders

    _overlayEntry = OverlayEntry(
      builder: (context) => const AbsorbPointer(
        absorbing: true, // Prevent user interactions
        child: Stack(
          children: [
             Opacity(
              opacity: 0.5,
              child: ModalBarrier(color: Colors.black, dismissible: false),
            ),
            Center(
                // child: LottieBuilder.asset('assets/animations/loading1.json'),
                child: CircularProgressIndicator()),
          ],
        ),
      ),
    );

    _navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
