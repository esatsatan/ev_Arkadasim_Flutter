import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserAuthRepository userAuthRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required this.userAuthRepository})
      : super(const AuthenticationState.unknown()) {
    _userSubscription = userAuthRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
    on<AuthenticationUserChanged>((event, emit) {
      //if (event is AuthenticationLogoutRequested) {} // kontrol et
      if (event.user != null) {
        emit(AuthenticationState.authenticated(
            event.user!)); // eğer kullanıcı yetkilendirilmişse
      } else {
        emit(const AuthenticationState
            .unauthenticated()); // eğer kullanıcı yetkilendirilmemişse
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
