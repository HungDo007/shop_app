mixin InputValidationMixin {
  bool isUsernameValid(String username) {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return usernameRegex.hasMatch(username);
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[0-9a-zA-Z!@#$%^&*]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  bool isPhoneValid(String phoneNumber) {
    final passwordRegex = RegExp(
        r'^[(]?[0-9]{3}[)]?[-\s]?[0-9]{3}[-\s]?[0-9]{4,6}$');
    return passwordRegex.hasMatch(phoneNumber);
  }
}