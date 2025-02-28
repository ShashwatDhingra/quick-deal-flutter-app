class ApiEndpionts {
  static const _baseUrl = 'https://quick-deal.onrender.com/api/v1';

  /// Confirm Mail
  static const confirmEmailUrl = '$_baseUrl/auth/confirm-mail';

  /// Verify Confirm Mail Pin
  static const verifyConfirmMailPinUrl =
      '$_baseUrl/auth/verify-confirm-mail-pin';

  /// Login
  static const loginUrl = '$_baseUrl/auth/login';

  /// Signup
  static const signupUrl = '$_baseUrl/auth/signup';

  /// Forget Password
  static const forgetPasswordUrl = '$_baseUrl/auth/forget-password';

  /// Verify Reset PIN
  static const verifyResetPinUrl = '$_baseUrl/auth/verify-reset-pin';

  /// Reset Password
  static const resetPasswordUrl = '$_baseUrl/auth/reset-password';

  /// Add Property
  static const addPropertyUrl = '$_baseUrl/property';
}
