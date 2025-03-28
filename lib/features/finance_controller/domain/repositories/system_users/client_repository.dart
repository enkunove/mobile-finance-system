import '../../entities/system_users/system_user.dart';

abstract class ClientRepository {

  Future<bool>register(User user);
  Future<dynamic>login(String username, String password);
  Future<void> updateClientById(User user);
  Future<List<User>> getAllRegistrationRequests();
  Future<void> deleteClient(int id);
}
