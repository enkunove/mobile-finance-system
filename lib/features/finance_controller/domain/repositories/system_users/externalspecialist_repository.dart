import '../../entities/system_users/client.dart';

abstract class ExternalSpecialistRepository {

  Future<bool>register(Client client);
  Future<dynamic>login(String username, String password);
  Future<void> updateClientById(Client client);
  Future<List<Client>> getAllRegistrationRequests();
  Future<void> deleteClient(int id);
}
