class User {
  int userId;
  String firstName;
  String email;
  String lastName;
  String token;
  String renewalToken;

  User(
      {required this.userId,
      required this.firstName,
      required this.email,
      required this.lastName,
      required this.token,
      required this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        firstName: responseData['name'],
        email: responseData['email'],
        lastName: responseData['phone'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']);
  }
}
