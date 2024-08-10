import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/clients.dart';
import 'package:flutter_test_app/data/orders.dart';
import 'package:flutter_test_app/data/tasks.dart';
import 'package:flutter_test_app/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slide_switcher/slide_switcher.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  int isActive = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            size: 30.w,
            color: Color.fromARGB(255, 89, 81, 246),
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.leaderboard_rounded,
              size: 30.w,
              color: Color.fromARGB(255, 89, 81, 246),
            ),
            onPressed: () {
              Box<Order> contactsBox = Hive.box<Order>(HiveBoxes.order);
              Box<Client> cliBox = Hive.box<Client>(HiveBoxes.client);
              int count = 0;
              int index = 0;
              int client = cliBox.length;

              for (int i = 0; i < contactsBox.length; i++) {
                if (contactsBox.getAt(i)!.isComplte) {
                  index += 1;
                  count += contactsBox
                      .getAt(i)!
                      .tasks!
                      .task
                      .map((task) => int.tryParse(task.price) ?? 0)
                      .reduce((a, b) => a + b);
                }
              }
              print(count);
              print(index);
              print(client);
              Navigator.of(
                context,
              ).pushNamed(statistics_page, arguments: [count, index, client]);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30.w,
              color: Color.fromARGB(255, 89, 81, 246),
            ),
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(client_page, arguments: true);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Order>(HiveBoxes.order).listenable(),
          builder: (context, Box<Order> box, _) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0.w, left: 20.0.w),
                child: Column(
                  children: [
                    Container(
                      width: 370.w,
                      child: Text(
                        "My orders",
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    box.values.isEmpty
                        ? SizedBox.shrink()
                        : Center(
                            child: SlideSwitcher(
                              children: [
                                Text('Active'),
                                Text('Completed'),
                              ],
                              containerColor: Color.fromARGB(255, 89, 81, 246),
                              slidersColors: [
                                Color.fromARGB(255, 183, 192, 251)
                              ],
                              containerBorderRadius: 10.r,
                              onSelect: (index) {
                                if (isActive != index) {
                                  setState(() {
                                    isActive = index;
                                  });
                                }
                                print(index);
                              },
                              containerHeight: 40.h,
                              containerWight: 360.w,
                            ),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    box.values.isEmpty
                        ? Container(
                            height: 400.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.2), // Цвет тени
                                    blurRadius: 10.0, // Размытие тени
                                    spreadRadius: 2.0, // Размер тени
                                    offset: Offset(4.0, 4.0), // Смещение тени
                                  ),
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.2), // Цвет тени
                                    blurRadius: 10.0, // Размытие тени
                                    spreadRadius: 2.0, // Размер тени
                                    offset: Offset(-1.0, -1.0), // Смещение тени
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.r))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 200.h,
                                    width: 380.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/web-development.png")),
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "No order yet",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Click the button to add your first order",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                return isActive == 0
                                    ? box.getAt(index)!.isComplte
                                        ? SizedBox.shrink()
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              top: 4.h,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(
                                                  context,
                                                ).pushNamed(info_order_page,
                                                    arguments: index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 89, 81, 246),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.r))),
                                                child: ListTile(
                                                  leading: null,
                                                  title: Text(
                                                    box
                                                        .getAt(index)!
                                                        .order_name,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp),
                                                  ),
                                                  subtitle: Text(
                                                    box
                                                        .getAt(index)!
                                                        .order_date,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 183, 192, 251),
                                                        fontSize: 14.sp),
                                                  ),
                                                  trailing: Text(
                                                    box.getAt(index)!.tasks ==
                                                            null
                                                        ? ""
                                                        : box
                                                            .getAt(index)!
                                                            .tasks!
                                                            .task
                                                            .map((task) =>
                                                                int.tryParse(task
                                                                    .price) ??
                                                                0)
                                                            .reduce(
                                                                (a, b) => a + b)
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                    : box.getAt(index)!.isComplte
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                              top: 4.h,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 89, 81, 246),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.r))),
                                              child: ListTile(
                                                leading: null,
                                                title: Text(
                                                  box.getAt(index)!.order_name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp),
                                                ),
                                                subtitle: Text(
                                                  box.getAt(index)!.order_date,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 183, 192, 251),
                                                      fontSize: 14.sp),
                                                ),
                                                trailing: Text(
                                                  box
                                                      .getAt(index)!
                                                      .tasks!
                                                      .task
                                                      .map((task) =>
                                                          int.tryParse(
                                                              task.price) ??
                                                          0)
                                                      .reduce((a, b) => a + b)
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink();
                              },
                            ),
                          ),
                    box.values.isEmpty
                        ? Expanded(child: Container())
                        : SizedBox(
                            height: 20.h,
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(
                            add_order_page,
                          );
                        },
                        child: Container(
                          height: 50.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r))),
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
