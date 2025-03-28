import 'client.dart';

class ExternalSpecialist extends Client {
  ExternalSpecialist(
      {required super.username,
      required super.password,
      required super.fullName,
      required super.passportSeriesAndNumber,
      required super.idNumber,
      required super.phone,
      required super.email,
      super.isApproved,
      required super.role

      });

  @override
  String get role => "ExternalSpecialist";
}
