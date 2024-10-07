
class SignUpModel{

  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String? agree;
  final String username;
  final String password;
  final String passwordConfirmation;
  final String countryCode;
  final String country;
  final String mobileCode;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.agree,
    required this.username,
    required this.password,
    required this.passwordConfirmation,
    required  this.countryCode,
    required this.country,
    required this.mobileCode
  });
}