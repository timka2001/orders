import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/orders.dart';
import 'package:flutter_test_app/data/tasks.dart';
import 'package:flutter_test_app/navigation/navigation.dart';
import 'package:hive/hive.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final List<GlobalKey<FormState>> _formKeys = [];
  final List<bool> _isTaskNameFilled = [];
  final List<bool> _isPriceFilled = [];
  final List<Task> tasks = []; // Список для хранения задач
  final List<Widget> taskFields = [];

  // Текущие контроллеры для текстовых полей
  final List<TextEditingController> _taskNameControllers = [];
  final List<TextEditingController> _priceControllers = [];

  void _updateFormCompletion() {
    setState(() {});
  }

  bool _checkAllFieldsFilled() {
    if (taskFields.isEmpty) {
      return false;
    }
    for (int index = 0; index < taskFields.length; index++) {
      if (!_isTaskNameFilled[index] || !_isPriceFilled[index]) {
        return false;
      }
    }
    return true;
  }

  void _addTaskField() {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    _formKeys.add(formKey);
    _isTaskNameFilled.add(false);
    _isPriceFilled.add(false);

    // Создаем контроллеры для текстовых полей
    TextEditingController taskNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    _taskNameControllers.add(taskNameController);
    _priceControllers.add(priceController);

    setState(() {
      taskFields.add(
        Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0.h),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 89, 81, 246),
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Text(
                    "Task ${taskFields.length + 1}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        right: 10.w, left: 10.w, top: 5.w, bottom: 5.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 174, 184, 246),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0.w),
                        child: TextField(
                          controller: taskNameController,
                          onChanged: (value) {
                            int index =
                                taskFields.length - 1; // Индекс текущего поля
                            _isTaskNameFilled[index] = value.isNotEmpty;
                            _updateFormCompletion();
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none, // Убираем обводку
                              focusedBorder: InputBorder
                                  .none, // Убираем обводку при фокусе
                              hintText: 'Task name',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(
                      right: 10.w, left: 10.w, top: 5.w, bottom: 5.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 174, 184, 246),
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0.w),
                      child: TextField(
                        controller: priceController,
                        onChanged: (value) {
                          int index =
                              taskFields.length - 1; // Индекс текущего поля
                          _isPriceFilled[index] = value.isNotEmpty;
                          _updateFormCompletion();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, // Убираем обводку
                            focusedBorder:
                                InputBorder.none, // Убираем обводку при фокусе
                            hintText: 'Price',
                            hintStyle: TextStyle(color: Colors.white)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _onNext() {
    // Заполнение списка задач
    tasks.clear(); // Очищаем, если это необходимо
    for (int index = 0; index < taskFields.length; index++) {
      if (_isTaskNameFilled[index] && _isPriceFilled[index]) {
        // Получаем значения из соответствующих текстовых полей
        final taskName = _taskNameControllers[index].text;
        final price = _priceControllers[index].text;

        tasks.add(Task(
          task_name: taskName,
          price: price,
        ));
      }
    }

    Tasks allTasks = Tasks(task: tasks);

    Box<Order> contactsBox = Hive.box<Order>(HiveBoxes.order);
    Order? currentOrder = contactsBox.getAt(contactsBox.length - 1);

    if (currentOrder != null) {
      currentOrder.tasks = allTasks;
      print(allTasks.task);
      contactsBox.putAt(contactsBox.length - 1, currentOrder);
    }

    Navigator.of(context).pushNamed(client_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                children: [
                  Container(
                    width: 160.w,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                        ),
                        Text(
                          "Add a new order",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Tasks",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _checkAllFieldsFilled()
                            ? _onNext // Вызов функции при нажатии на кнопку "Next"
                            : null,
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: _checkAllFieldsFilled()
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: taskFields.length,
                itemBuilder: (context, index) {
                  return taskFields[index];
                },
              ),
            ),
            GestureDetector(
              onTap: _addTaskField,
              child: Container(
                width: 150.w,
                height: 50.h,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                child: Center(child: Text("Add Task")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
