import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_arkadasim/src/model/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var verificationId = '';

  Future<User?> createUser(
      {required String email,
      required String password,
      required String username,
      required String university}) async {
    String res = "Some Error occurred";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(credential.user!.uid);

      model.User user = model.User(
          username: username,
          email: email,
          password: password,
          university: university);

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toJson());
      res = "Success";
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      final UserCredential authresult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = authresult.user;
      print('OTURUM AÇILDI!!');
    } on FirebaseAuthException catch (error) {
      print('oturum açılamadı çünkü : $error');
    }
  }

  Future sendVerificationEmail() async {
    String res = "Some Error occureed";
    try {
      await _auth.currentUser?.sendEmailVerification();
      res = "success";
    } catch (e) {
      print("error caused by : ${e.toString()}");
      res = e.toString();
    }
  }

  Future userLogout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Çıkış yapılamadı');
    }
  }

  Future<void> loginWithPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+90$phoneNumber}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {}
      },
      codeSent: (String verificationId, int? resendToken) {
        //OTP = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void handleVerificationCompleted(PhoneAuthCredential credential) {
    // Bu fonksiyonda doğrulama bilgileri ile özel işlemleri gerçekleştirebilirsiniz.
    // Örneğin, bir kullanıcı doğrulandıktan sonra özel bir ekranı göstermek gibi.
    print('Doğrulama tamamlandı, özel işlemler gerçekleştirilebilir.');
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("OTP doğrulama başarılı!");
      // Kullanıcı başarılı bir şekilde doğrulandı.
      // Burada istediğiniz işlemleri gerçekleştirebilirsiniz.
    } catch (e) {
      print("OTP doğrulama hatası: $e");
      // Doğrulama hatası, kullanıcının girdiği OTP kodu geçersiz.
      // Hata mesajını kontrol edebilir ve kullanıcıya uygun bir geri bildirimde bulunabilirsiniz.
    }
  }


}
