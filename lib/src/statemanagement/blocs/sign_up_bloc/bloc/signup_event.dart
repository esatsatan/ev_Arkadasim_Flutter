part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignupEvent {
  final MyUser user;
  final String password;

  const SignUpRequired(this.user, this.password);
}
