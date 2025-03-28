class User {
  final String username;
  final String password;
  final String fullName;
  final String passportSeriesAndNumber;
  final int idNumber;
  final String phone;
  final String email;
  bool isApproved;
  String role;

  User({
    required this.username,
    required this.password,
    required this.fullName,
    required this.passportSeriesAndNumber,
    required this.idNumber,
    required this.phone,
    required this.email,
    this.isApproved = false,
    required this.role,
  });
}
