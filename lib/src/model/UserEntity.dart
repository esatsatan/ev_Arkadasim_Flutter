import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String username;
  final String email;
  final String password;
  final String university;

  const UserEntity({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.university,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'university': university,
    };
  }

  static UserEntity fromDocument(Map<String, dynamic> doc) {
    return UserEntity(
      userId: doc['userId'],
      username: doc['username'],
      email: doc['email'],
      password: doc['password'],
      university: doc['university']
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, username, email, password, university];
}
