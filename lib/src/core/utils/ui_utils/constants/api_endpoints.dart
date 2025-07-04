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

  /// create Lead
  static const createLeadUrl = '$_baseUrl/lead';

  /// create followup

  static const followup = '$_baseUrl/followup';

  /// Forget Password
  static const forgetPasswordUrl = '$_baseUrl/auth/forget-password';

  /// Verify Reset PIN
  static const verifyResetPinUrl = '$_baseUrl/auth/verify-reset-pin';

  /// Reset Password
  static const resetPasswordUrl = '$_baseUrl/auth/reset-password';

  /// Send Firebase Token
  static const sendFirebaseToken = "$_baseUrl/auth/send-firebase-token";

  /// Add Property
  static const propertyUrl = '$_baseUrl/property';
}
