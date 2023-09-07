class User {
  final String username;
  final String email;
  final String password;
  final String university;

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.university});

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
    "university": university,
 };

 
}
