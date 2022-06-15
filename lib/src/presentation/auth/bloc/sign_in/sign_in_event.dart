abstract class SignInEvent {
  const SignInEvent();
}

class ClickSignInEvent extends SignInEvent {
  const ClickSignInEvent(this.email, this.password);

  final String email;
  final String password;
}