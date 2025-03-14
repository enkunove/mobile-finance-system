import '../../entities/system_users/client.dart';

abstract class ClientRepository {

  Future<bool>register(Client client);
  Future<Client?>login(String username, String password);
}
