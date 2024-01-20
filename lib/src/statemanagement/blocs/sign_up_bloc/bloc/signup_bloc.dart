import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepository.dart';
import 'package:ev_arkadasim/src/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserAuthRepository _userAuthRepository;

  SignupBloc({
    required UserAuthRepository userAuthRepository,
  })  : _userAuthRepository = userAuthRepository,
        super(SignupInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());

      try {
        MyUser user = await _userAuthRepository.signUp(
            event.user,
            event.user.username,
            event.user.email,
            event.user.password,
            event.user.university);

        // mail adresinin doğrulanması için bir doğrulama linki gönder.
        await _userAuthRepository.sendEmailVerification();

        // E-posta doğrulamasını dinleyerek işlemi takip et.
        _waitForEmailVerification(user);

        //await _userAuthRepository.setUserData(user); // add user data to firebase firestore.
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }

  // E-posta doğrulamasını takip etmek için yardımcı fonksiyon.
  Stream<SignupState> _waitForEmailVerification(MyUser user) async* {
    try {
      // Firebase Authentication'dan kullanıcının e-posta doğrulama durumunu kontrol et.
      /*
      await for (final _ in FirebaseAuth.instance.authStateChanges()) {
        User? firebaseUser = FirebaseAuth.instance.currentUser;

        if (firebaseUser != null && firebaseUser.emailVerified) {
          // Eğer kullanıcı e-posta doğrulamasını tamamlamışsa, SignUpSuccess state'ini emit et.
          // ignore: invalid_use_of_visible_for_testing_member
          emit(SignUpSuccess(isEmailVerified: true));

          // İsteğe bağlı olarak kullanıcı bilgilerini Firestore'a ekleyebilirsiniz.
          await _userAuthRepository.setUserData(user);
        }
      }
      */

      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null && user.emailVerified) {
          // Eğer kullanıcı e-posta doğrulamasını tamamlamışsa, ana sayfaya yönlendir.
          await user.reload;
          // ignore: invalid_use_of_visible_for_testing_member
          emit(SignUpSuccess(isEmailVerified: true));
        }
      });
    } catch (e) {
      // E-posta doğrulama işlemi başarısız olursa SignUpFailure state'ini emit et.
      yield SignUpFailure();
    }
  }
}
