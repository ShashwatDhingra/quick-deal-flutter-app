import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/presentation/features/property/states/second_page_state.dart';

class SecondPage extends ConsumerStatefulWidget {
  const SecondPage({super.key});

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final secondPageState = ref.watch(secondPageStateProvider);
    final secondPageNotifier = ref.read(secondPageStateProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            7.0.hBox,
            Center(
                child: Text('Add Some Images',
                    style: Theme.of(context).textTheme.labelLarge)),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 6.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(secondPageState.selectedImages.length.toString()),
                      const Text(' Selected Images'),
                      const Spacer(),
                      GestureDetector(
                        onTap: secondPageState.selectedImages.length < 25
                            ? secondPageNotifier.pickImages
                            : null,
                        child: Container(
                            margin: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.7, color: Colors.grey),
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Icon(Icons.add)),
                      ),
                    ],
                  )),
            ),
            4.hBox,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey, width: 0.7)),
                child: secondPageState.selectedImages.isEmpty
                    ? Center(
                        child: Icon(
                        Icons.image,
                        color: Colors.grey.withOpacity(0.5),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemCount: secondPageState.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(secondPageState
                                        .selectedImages[index].path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      secondPageNotifier.removeImage(index);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(Icons.close,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
