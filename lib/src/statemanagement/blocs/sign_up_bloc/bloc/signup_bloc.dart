import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepository.dart';
import 'package:ev_arkadasim/src/model/user.dart';

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
        await _userAuthRepository
            .setUserData(user); // add user data to firebase firestore.
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
