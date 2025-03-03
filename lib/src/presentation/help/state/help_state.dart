import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/presentation/global/user_provider.dart';

class HelpSupportState {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;

  HelpSupportState({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? subjectController,
    TextEditingController? messageController,
  })  : nameController = nameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        subjectController = subjectController ?? TextEditingController(),
        messageController = messageController ?? TextEditingController();

  HelpSupportState copyWith({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? subjectController,
    TextEditingController? messageController,
  }) {
    return HelpSupportState(
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      subjectController: subjectController ?? this.subjectController,
      messageController: messageController ?? this.messageController,
    );
  }
}

class HelpSupportStateNotifier extends StateNotifier<HelpSupportState> {
  final helpFormKey = GlobalKey<FormState>();

  HelpSupportStateNotifier(Ref ref) : super(HelpSupportState()) {
    state = state.copyWith(
        nameController:
            TextEditingController(text: ref.read(userProvider)!.name),
        emailController:
            TextEditingController(text: ref.read(userProvider)!.email));
  }

  void clearAllControllers() {
    state.nameController.clear();
    state.emailController.clear();
    state.subjectController.clear();
    state.messageController.clear();
  }

  Future<void> submitHelpRequest(WidgetRef ref) async {
    if (helpFormKey.currentState!.validate()) {
      // Process help request data
      // print('Name: ${state.nameController.text}');
      // print('Email: ${state.emailController.text}');
      // print('Subject: ${state.subjectController.text}');
      // print('Message: ${state.messageController.text}');

      // Show success message
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Text('Help request submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

final helpSupportStateProvider =
    StateNotifierProvider<HelpSupportStateNotifier, HelpSupportState>(
        (ref) => HelpSupportStateNotifier(ref));
