import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

abstract class UserAuthRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(
    MyUser user,
    String username,
    String email,
    String password,
    String university,
  );

  Future<void> sendEmailVerification();

  Future<void> signIn(
    String email,
    String password,
  );

  Future<void> setUserData(MyUser user);

  Future<void> signOut();
}
