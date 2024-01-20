import 'package:ev_arkadasim/src/authentication/AuthRepository.dart';
import 'package:ev_arkadasim/src/authentication/VerifyEmailScreen.dart';
import 'package:ev_arkadasim/src/home/BaseScreen.dart';
import 'package:ev_arkadasim/src/login/SignIn.dart';
import 'package:ev_arkadasim/src/model/user.dart';
import 'package:ev_arkadasim/src/statemanagement/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ev_arkadasim/src/statemanagement/blocs/sign_up_bloc/bloc/signup_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeusername = FocusNode();
  final FocusNode _focusNodeUni = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUni = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();
  AuthService _authService = AuthService();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool signUpRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(
        userAuthRepository:
            context.read<AuthenticationBloc>().userAuthRepository,
      ),
      child: SignUpWt(),
    );
  }
}

class SignUpWt extends StatefulWidget {
  @override
  State<SignUpWt> createState() => _SignUpWtState();
}

class _SignUpWtState extends State<SignUpWt> {
  //const SignUpWt({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();

  final FocusNode _focusNodeusername = FocusNode();

  final FocusNode _focusNodeUni = FocusNode();

  final FocusNode _focusNodePassword = FocusNode();

  final FocusNode _focusNodeConfirmPassword = FocusNode();

  final TextEditingController _controllerUsername = TextEditingController();

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  final TextEditingController _controllerUni = TextEditingController();

  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  AuthService _authService = AuthService();

  bool _obscurePassword = true;

  bool _isLoading = false;

  bool signUpRequired = false;

  bool isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    final signupBloc = BlocProvider.of<SignupBloc>(context);

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BaseScreen(),
              ), // AnaSayfa yerine kendi ana sayfanızı kullanın.
            );
          });
          if (state.isEmailVerified) {}
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Kayıt ol',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hesap oluştur",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 35),
                TextFormField(
                  controller: _controllerUsername,
                  focusNode: _focusNodeusername,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Ad ve Soyad",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter username.";
                    }
                    return null;
                  },
                  onEditingComplete: () => _focusNodeusername.requestFocus(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email giriniz";
                    }
                    return null;
                  },
                  onEditingComplete: () => _focusNodeEmail.requestFocus(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen Şifre giriniz";
                    }
                    return null;
                  },
                  onEditingComplete: () =>
                      _focusNodeConfirmPassword.requestFocus(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerUni,
                  focusNode: _focusNodeUni,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Üniversite",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email.";
                    }
                    return null;
                  },
                  onEditingComplete: () => _focusNodeUni.requestFocus(),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          MyUser myuser = MyUser.empty;
                          myuser = myuser.copyWith(
                            email: _controllerEmail.text,
                            password: _controllerPassword.text,
                          );
                          setState(() {
                            context.read<SignupBloc>().add(
                                  SignUpRequired(
                                    myuser,
                                    _controllerPassword.text,
                                  ),
                                );
                          });
                        }
                      },
                      child: const Text(
                        "Kayıt ol",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Zaten hesabınız var mı?'),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          ),
                          child: Text(
                            "Giriş Yapın",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
