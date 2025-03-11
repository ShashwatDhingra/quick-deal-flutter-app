import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quickdeal/src/core/utils/ui_utils/loading_manager.dart';
import 'package:quickdeal/src/data/api_exception.dart';
import 'package:quickdeal/src/data/repository/auth_repository.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import '../../../../data/models/user_model.dart';
import '../../../global/user_provider.dart';

class SignupState {
  // Signup Screen
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController cnfrmPassController;

  // Verify Pin bottom sheet
  List<TextEditingController> pinControllers;

  bool isEmailConfirmed = false;

  AuthRepository authRepo = AuthRepository();

  SignupState({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.cnfrmPassController,
    required this.pinControllers,
    required this.authRepo,
    this.isEmailConfirmed = false,
  });

  SignupState copyWith({bool? isEmailConfirmed}) {
    return SignupState(
      nameController: nameController,
      emailController: emailController,
      passwordController: passwordController,
      cnfrmPassController: cnfrmPassController,
      pinControllers: pinControllers,
      authRepo: authRepo,
      isEmailConfirmed: isEmailConfirmed ?? this.isEmailConfirmed,
    );
  }
}

class SignupStateNotifier extends StateNotifier<SignupState> {
  final signupFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final pinFormKey = GlobalKey<FormState>();
  SignupStateNotifier()
      : super(SignupState(
          nameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          cnfrmPassController: TextEditingController(),
          pinControllers: List.generate(4, (index) => TextEditingController()),
          authRepo: AuthRepository(),
        ));

  Future<bool> signup(WidgetRef ref) async {
    try {
      if (!signupFormKey.currentState!.validate()) {
        return false;
      }

      LoadingManager.showLoading();
      final response = await state.authRepo.signup(
          name: state.nameController.text,
          email: state.emailController.text,
          password: state.passwordController.text);
      if (response?.success ?? false) {
        // Sending Firebase Token to server.
        var fcmToken = await FirebaseMessaging.instance.getToken();
        await state.authRepo
            .sendFirebaseToken(state.emailController.text, fcmToken ?? '');

        // Getting detail from jwt.
        final detail = JwtDecoder.decode(response?.data['token'] ?? '');

        // Filling the User Global Provider
        ref.read(userProvider.notifier).setUser(User.fromJson(detail));
        response?.message?.showToast();
        clearAllControllers();
      }
      return response?.success ?? false;
    } catch (e) {
      //! Error handling
      handleError(e); // handled showing error toast itself.
      return false;
    } finally {
      LoadingManager.hideLoading();
    }
  }

  Future<bool> confirmMail() async {
    try {
      if (!emailFormKey.currentState!.validate()) {
        return false;
      }
      LoadingManager.showLoading();
      final response =
          await state.authRepo.confirmMail(state.emailController.text);
      if (response.success ?? false) {
        response.message?.showToast();
        "hello".showToast();
      }
      return response.success ?? false;
    } catch (e) {
      //! Error handling
      handleError(e); // handled showing error toast itself.
      return false;
    } finally {
      LoadingManager.hideLoading();
    }
  }

  Future<bool> verifyPin() async {
    try {
      if (!pinFormKey.currentState!.validate()) {
        return false;
      }
      LoadingManager.showLoading();
      final response = await state.authRepo
          .verifyConfirmMailPin(state.emailController.text, generatePin());
      if (response.success ?? false) {
        // final email = state.emailController.text;
        state = state.copyWith(
          isEmailConfirmed: true,
        );
      }
      return response.success ?? false;
    } catch (e) {
      //! Error handling
      handleError(e); // handled showing error toast itself.
      return false;
    } finally {
      LoadingManager.hideLoading();
    }
  }

  int generatePin() {
    List<String> pin = [];
    for (int i = 0; i <= 3; i++) {
      pin.add(state.pinControllers[i].text);
    }
    return int.parse(pin.join());
  }

  // void toogleLoading(bool status) {
  //   state = state.copyWith(isLoading: status);
  // }

  void clearAllControllers() {
    state.emailController.clear();
    state.passwordController.clear();
    state.nameController.clear();
    state.cnfrmPassController.clear();
    for (var ctrls in state.pinControllers) {
      ctrls.clear();
    }
  }
}

// Provider for the same
final signupStateProvider =
    StateNotifierProvider<SignupStateNotifier, SignupState>(
        (ref) => SignupStateNotifier());
