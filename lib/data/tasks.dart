import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 3) // Use a different typeId for each class
class Tasks {
  @HiveField(0)
  List<Task> task;

  Tasks({required this.task});
}

@HiveType(typeId: 4)
class Task {
  @HiveField(0)
  String task_name;

  @HiveField(1)
  String price;

  Task({this.task_name = '', this.price = ''});
}
