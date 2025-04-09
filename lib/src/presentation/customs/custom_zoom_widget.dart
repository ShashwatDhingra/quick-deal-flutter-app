import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class ZoomWidget extends StatelessWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final bool panEnabled;

  const ZoomWidget({
    super.key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 4.0,
    this.panEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: minScale,
      maxScale: maxScale,
      panEnabled: panEnabled,
      
      boundaryMargin: const EdgeInsets.all(double.infinity),
      child: child,
    );
  }
}

// Usage:
// ZoomableWidget(
//   child: YourWidget(),
// )

// ignore: must_be_immutable
class ZoomImg extends StatelessWidget {
  ZoomImg({super.key, required this.itemList});

  List<String> itemList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: itemList.isNotEmpty
          ? SafeArea(
              child: Stack(
                children: [
                  PageView(
                    children: List.generate(
                      itemList.length,
                      (index) {
                        return ZoomWidget(
                            child: Image(
                                image:
                                    NetworkImage(itemList[index].toString())));
                      },
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.pop();
                        },
                      ))
                ],
              ),
            )
          : Center(
              child: Text("No data found"),
            ),
    );
  }
}
