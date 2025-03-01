import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quickdeal/src/core/router/router.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/loading_manager.dart';
import 'package:quickdeal/src/data/api_exception.dart';
import 'package:quickdeal/src/data/repository/auth_repository.dart';

import '../../../../data/models/user_model.dart';
import '../../../global/user_provider.dart';

class SigninState {
  final bool isLoading;
  // Signin Screen
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Verify email bottom sheet
  final TextEditingController fpEmailController = TextEditingController();

  // Verify Pin bottom sheet
  final pinControllers = List.generate(4, (index) => TextEditingController());

  // Set password bottom sheet
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController cnfrmNewPassCtrl = TextEditingController();

  final AuthRepository authRepo = AuthRepository();

  // In constructor we generally initialize with default value of variables.
  SigninState({this.isLoading = false});

  // Method to copy the state with update version
  SigninState copyWith({
    bool? isLoading,
  }) {
    return SigninState(isLoading: isLoading ?? this.isLoading);
  }
}

class SigninStateNotifier extends StateNotifier<SigninState> {
  final signinFormKey = GlobalKey<FormState>();
  final fpFormKey = GlobalKey<FormState>();
  final pinFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  // Initialize the HomeState in super method of HomeStateNotifier
  SigninStateNotifier() : super(SigninState());

  Future<bool> login(WidgetRef ref) async {
    try {
      if (!signinFormKey.currentState!.validate()) {
        return false;
      }

      LoadingManager.showLoading();
      final response = await state.authRepo
          .login(state.emailController.text, state.passwordController.text);
      if (response?.success ?? false) {
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

  Future<bool> sendVerificationCode() async {
    try {
      if (!fpFormKey.currentState!.validate()) {
        return false;
      }
      LoadingManager.showLoading();
      final response =
          await state.authRepo.forgetPassword(state.fpEmailController.text);
      if (response.success ?? false) {
        // state.fpEmailController.clear();
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
          .verifyResetPasswordPin(state.fpEmailController.text, generatePin());
      return response.success ?? false;
    } catch (e) {
      //! Error handling
      handleError(e); // handled showing error toast itself.
      return false;
    } finally {
      LoadingManager.hideLoading();
    }
  }

  Future<bool> resetPassword() async {
    try {
      if (!resetPasswordFormKey.currentState!.validate()) {
        return false;
      }
      LoadingManager.showLoading();
      final response = await state.authRepo.resetPassword(
          state.fpEmailController.text, state.cnfrmNewPassCtrl.text);
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

  void toogleLoading(bool status) {
    state = state.copyWith(isLoading: status);
  }

  void clearAllControllers() {
    state.emailController.clear();
    state.passwordController.clear();
    state.fpEmailController.clear();
    state.newPassCtrl.clear();
    state.cnfrmNewPassCtrl.clear();
    for (var ctrls in state.pinControllers) {
      ctrls.clear();
    }
  }
}

// Provider for the same
final signinStateProvider =
    StateNotifierProvider<SigninStateNotifier, SigninState>(
        (ref) => SigninStateNotifier());
