import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/orders.dart';
import 'package:flutter_test_app/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddOrderPage extends StatefulWidget {
  AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  // PageController for navigating between months.
  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  ScrollController listscollcont = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  DateTime _currentMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now(); // Track the selected date
  String priority = '';
  String level = '';

  @override
  void initState() {
    super.initState();
    // Инициализируем значения потока
    _updateFormCompletion();

    nameController.addListener(_updateFormCompletion);
    descriptionController.addListener(_updateFormCompletion);
    deadlineController.addListener(_updateFormCompletion);
  }

  _updateFormCompletion() {
    // Проверяем, заполнены ли все поля
    bool isFilled = nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        deadlineController.text.isNotEmpty &&
        priority.isNotEmpty &&
        level.isNotEmpty;

    // Добавляем значение в поток
    return isFilled;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(right: 20.0.w, left: 20.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                        ),
                        Text(
                          "My order",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      if (_updateFormCompletion()) {
                        print("object");
                        Box<Order> contactsBox =
                            Hive.box<Order>(HiveBoxes.order);
                        contactsBox.add(Order(
                            order_name: nameController.text,
                            order_description: descriptionController.text,
                            order_date: deadlineController.text,
                            priority: priority == "Yes" ? true : false,
                            difficulty: level,
                            isComplte: false));
                        print(contactsBox.length);
                        Navigator.of(
                          context,
                        ).pushNamed(add_task_page);
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: _updateFormCompletion()
                              ? Colors.blue
                              : Colors.grey),
                    ))
              ]),
              Padding(
                padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                child: Container(
                  width: 400.w,
                  child: Text(
                    "Add a new order",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Color.fromARGB(255, 183, 192, 251)),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Убираем обводку
                      focusedBorder:
                          InputBorder.none, // Убираем обводку при фокусе
                      hintText: 'Name',
                    ),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      print(nameController.value.text);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  color: Color.fromARGB(255, 183, 192, 251),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: TextField(
                    minLines: 1,
                    maxLines: 10,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Убираем обводку
                      focusedBorder:
                          InputBorder.none, // Убираем обводку при фокусе
                    ),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      print(descriptionController.value.text);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "Deadline",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Color.fromARGB(255, 183, 192, 251)),
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: TextField(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 410.h,
                              color: Colors.blue,
                              child: Column(
                                children: [
                                  _buildHeader(),
                                  Container(
                                    height: 370.h,
                                    child: PageView.builder(
                                      controller: _pageController,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentMonth = DateTime(
                                              _currentMonth.year,
                                              (index % 12) + 1,
                                              1);
                                        });
                                      },
                                      itemCount: 12 * 2,
                                      itemBuilder: (context, pageIndex) {
                                        DateTime month = DateTime(
                                            _currentMonth.year,
                                            _currentMonth.month,
                                            1);
                                        return buildCalendar(month);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    readOnly: true,
                    showCursor: false, // Скрывает курсор
                    controller: deadlineController,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Убираем обводку
                      focusedBorder:
                          InputBorder.none, // Убираем обводку при фокусе
                      hintText: 'Deadline',
                    ),

                    cursorColor: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "Priority",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ["Yes", "No"].map((toElement) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          priority = toElement;
                          _updateFormCompletion();
                        });
                      },
                      child: Container(
                        width: 170.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: priority == toElement
                                ? Colors.deepOrange
                                : Color.fromARGB(255, 89, 81, 246),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.r))),
                        child: Center(
                          child: Text(
                            toElement,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
              Padding(
                padding: EdgeInsets.only(
                    right: 10.0.w, left: 10.w, top: 20.w, bottom: 10.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "Difficulty of execution",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ["Easy", "Medium", "Hard"].map((toElement) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          level = toElement;
                          _updateFormCompletion();
                        });
                      },
                      child: Container(
                        width: 110.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: level == toElement
                                ? Colors.deepOrange
                                : Color.fromARGB(255, 89, 81, 246),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.r))),
                        child: Center(
                          child: Text(
                            toElement,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildCalendar(DateTime month) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    List<Widget> calendarCells = [];

    // Add weekday labels
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (String day in weekDays) {
      calendarCells.add(
        Container(
          decoration: const BoxDecoration(border: Border()),
          alignment: Alignment.center,
          child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }

    // Add empty cells for the days before the first day of the month
    for (int i = 0; i < weekdayOfFirstDay - 1; i++) {
      calendarCells.add(Container(
          decoration: const BoxDecoration(border: Border()),
          alignment: Alignment.center,
          child: Text("")));
    }

    // Add the current month's days
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(month.year, month.month, i);
      calendarCells.add(
        GestureDetector(
          onTap: () {
            setState(() {
              // Set the selected date
              deadlineController.text =
                  DateFormat('dd.MM.yyyy').format(date).toString();
            });
            Navigator.pop(context);
            Future.delayed(Duration(milliseconds: 100), () {
              FocusScope.of(context).unfocus();
            });
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              decoration: BoxDecoration(
                // Use selected date to determine the color
                color: (_selectedDate.isSameDate(date))
                    ? Colors.deepOrange
                    : Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border(),
              ),
              child: Center(
                child: Text(date.day.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: 7,
      childAspectRatio: 1,
      children: calendarCells,
    );
  }

  Widget _buildHeader() {
    return Container(
        height: 40.h,
        width: 400.w,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Align(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: listscollcont,
              itemCount: 12 * 2,
              itemBuilder: (context, index) {
                int year = _currentMonth.year + (index ~/ 12);
                int month = (index % 12) + _currentMonth.month - 1;
                DateTime monthDate = DateTime(year, month);
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.only(right: 100.w),
                    child: Container(
                        child: Text(
                      DateFormat('yyyy').format(monthDate),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    )),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentMonth = monthDate; // Update the current month
                      _pageController.jumpToPage(
                          month - 1); // Jump to the corresponding page index
                      listscollcont.jumpTo(0);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 80.w),
                    child: Container(
                        child: Text(
                      DateFormat('MMMM yyyy').format(monthDate),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                );
              },
            ),
          ),
        ));
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
