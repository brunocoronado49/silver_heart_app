
abstract class SignUpEvent {
  const SignUpEvent();
}

class ClickSignUpEvent extends SignUpEvent {
  const ClickSignUpEvent(this.email, this.password, this.confirmPassword);

  final String email;
  final String password;
  final String confirmPassword;
}