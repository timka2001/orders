import 'package:hive/hive.dart';
part 'clients.g.dart';

@HiveType(typeId: 1)
class Client {
  @HiveField(0)
  String client_name;
  @HiveField(1)
  String client_description;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String mail;
  @HiveField(4)
  bool constants;
  Client(
      {this.client_name = '',
      this.client_description = '',
      this.phone = '',
      this.mail = '',
      this.constants = false});
}
