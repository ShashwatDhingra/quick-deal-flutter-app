import 'package:flutter/material.dart';

class LoadingManager {
  static final LoadingManager _instance = LoadingManager._internal();

  factory LoadingManager() => _instance;

  LoadingManager._internal();

  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static OverlayEntry? _overlayEntry;

  static void showLoading() {
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
                child: CircularProgressIndicator(
              strokeWidth: 1,
            )),
          ],
        ),
      ),
    );

    _navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  static void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
