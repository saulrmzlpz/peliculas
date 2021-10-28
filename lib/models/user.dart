class User {
  int userId;
  String email;
  String firstName;
  String lastName;
  String memberSince;
  User(
      {required this.userId,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.memberSince});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['Id'],
        email: json['UserEmail'],
        firstName: json['FirstName'],
        lastName: json['LastName'],
        memberSince: json['MemberSince']);
  }
}
