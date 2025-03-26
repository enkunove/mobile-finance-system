import 'client.dart';

class ExternalSpecialist extends Client {
  ExternalSpecialist(
      String username,
      String password, {
        required String fullName,
        required String passportSeriesAndNumber,
        required int idNumber,
        required String phone,
        required String email,
        required bool isApproved,
      }) : super(
    username,
    password,
    fullName: fullName,
    passportSeriesAndNumber: passportSeriesAndNumber,
    idNumber: idNumber,
    phone: phone,
    email: email,
    isApproved: isApproved,
  );

  @override
  String get role => "ExternalSpecialist";
}
