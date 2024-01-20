import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserAuthRepository _userAuthRepository;

  SigninBloc({required UserAuthRepository userAuthRepository})
      : _userAuthRepository = userAuthRepository,
        super(SigninInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userAuthRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
      } catch (e) {
        emit(const SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userAuthRepository
          .signOut(); // kullanıcının oturumu kapatmasını dinler.
    });
  }
}
