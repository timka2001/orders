import 'package:flutter_test_app/data/clients.dart';
import 'package:flutter_test_app/data/tasks.dart';
import 'package:hive/hive.dart';
part 'orders.g.dart';

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  String order_name;
  @HiveField(1)
  String order_description;
  @HiveField(2)
  String order_date;
  @HiveField(3)
  bool priority;
  @HiveField(4)
  String difficulty;
  @HiveField(5)
  Tasks? tasks;
  @HiveField(6)
  Client? client;
  @HiveField(7)
  bool isComplte;
  Order(
      {this.order_name = '',
      this.order_description = '',
      this.order_date = '',
      this.priority = false,
      this.difficulty = '',
      this.tasks,
      this.client,
      this.isComplte = false});
}
