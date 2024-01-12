import 'package:equatable/equatable.dart';
import 'package:ev_arkadasim/src/model/UserEntity.dart';

class MyUser extends Equatable {
  final String userId;
  final String username;
  final String email;
  final String password;
  final String university;

  const MyUser(
      {required this.userId,
      required this.username,
      required this.email,
      required this.password,
      required this.university});

  static const empty = MyUser(
    userId: '',
    username: '',
    email: '',
    password: '',
    university: '',
  );

  MyUser copyWith({
    String? userId,
    String? username,
    String? email,
    String? password,
    String? university,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      university: university ?? this.university,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      username: username,
      email: email,
      password: password,
      university: university,
    );
  }

  static MyUser fromEntity(UserEntity, entity) {
    return MyUser(
        userId: entity.userId,
        username: entity.username,
        email: entity.email,
        password: entity.password,
        university: entity.university);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "university": university,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [userId, username, email, password, university];
}
