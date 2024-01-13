part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SigninEvent {
  final String email;
  final String password;

  const SignInRequired(this.email, this.password);
}

class SignOutRequired extends SigninEvent {

  const SignOutRequired();
}
