import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepository.dart';
import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepositoryImp.dart';
import 'package:ev_arkadasim/src/statemanagement/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ev_arkadasim/src/home/BaseScreen.dart';
import 'package:ev_arkadasim/src/login/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(UserAuthRepositoryImp()));
}

class MyApp extends StatelessWidget {
  final UserAuthRepository userAuthRepository;
  const MyApp(this.userAuthRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) =>
          AuthenticationBloc(userAuthRepository: userAuthRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return BaseScreen();
            } else {
              return const SignIn();
            }
          },
        ),
      ),
    );
  }
}
