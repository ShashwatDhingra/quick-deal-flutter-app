import 'package:quickdeal/src/core/router/router.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';
import 'package:quickdeal/src/core/utils/ui_utils/loading_manager.dart';
import 'package:quickdeal/src/data/api_exception.dart';
import 'package:quickdeal/src/data/repository/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

class SigninState {
  final bool isLoading;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
  final formKey = GlobalKey<FormState>();
  // Initialize the HomeState in super method of HomeStateNotifier
  SigninStateNotifier() : super(SigninState());

  Future<bool> login() async {
    try {
      if (!formKey.currentState!.validate()) {
        return false;
      }

      LoadingManager.showLoading();
      final response = await state.authRepo
          .login(state.emailController.text, state.passwordController.text);
      return response?.success ?? false;
    } catch (e) {
      //! Error handling
      handleError(e); // handled showing error toast itself.
      return false;
    } finally {
      LoadingManager.hideLoading();
    }
  }

  void toogleLoading(bool status) {
    state = state.copyWith(isLoading: status);
  }
}

// Provider for the same
final signinStateProvider =
    StateNotifierProvider<SigninStateNotifier, SigninState>(
        (ref) => SigninStateNotifier());
