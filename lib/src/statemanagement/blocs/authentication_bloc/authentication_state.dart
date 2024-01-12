part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user});

  // default olarak kullanıcı unknown olarak tanınmlandı.
  const AuthenticationState.unknown() : this._();

  // yetkilendirilmiş kullanıcı
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  // yetkilendirilmemiş kullanıcı
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  // TODO: implement props
  List<Object?> get props => [status, user];
}
