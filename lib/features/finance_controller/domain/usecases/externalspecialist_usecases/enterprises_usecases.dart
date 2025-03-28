import 'package:finance_system_controller/features/finance_controller/domain/entities/enterprise.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

import '../../repositories/bank_repository.dart';

class EnterprisesUsecases{
  final BankRepository bankRepository;
  final Client user;

  EnterprisesUsecases(this.bankRepository, this.user);

  Future<void> createEnterprise(Enterprise enterprise) async{
    Client client = user;
    Enterprise bank = Enterprise(
      id: enterprise.id,
      type: enterprise.type,
      pin: enterprise.pin,
      address: enterprise.address,
      name: enterprise.name,
      bic: enterprise.bic,
      specialistId: client.idNumber,//нихуя не работает потому что клиент еще не взялся с бд(и берется с деволт значение getit). надо переделать
    );
    print("Usecases: $bank");
    await bankRepository.addBank(bank);
  }
}