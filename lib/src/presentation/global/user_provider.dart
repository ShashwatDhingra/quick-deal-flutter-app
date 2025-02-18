import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // Method to set the user data
  void setUser(User user) {
    state = user;
  }

  // Method to update specific fields
  void updateUser({String? email, String? name, String? role}) {
    if (state != null) {
      state = state!.copyWith(
        email: email,
        name: name,
        role: role,
      );
    }
  }

  // Method to clear user (logout)
  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
