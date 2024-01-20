part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

class SignUpSuccess extends SignupState{
   final bool isEmailVerified;

   SignUpSuccess({required this.isEmailVerified});

   @override
  List<Object> get props => [isEmailVerified];
}
class SignUpFailure extends SignupState{}
class SignUpProcess extends SignupState{}
