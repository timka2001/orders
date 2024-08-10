import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/clients.dart';
import 'package:flutter_test_app/data/orders.dart';
import 'package:flutter_test_app/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClientPage extends StatefulWidget {
  ClientPage({super.key, this.is_pre_order = false});
  bool is_pre_order; // Сделайте поле final
  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage>
    with SingleTickerProviderStateMixin {
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
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.blue),
                  Text(
                    widget.is_pre_order ? "Back" : "Task",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
          ),
        ),
        leadingWidth: 100.w,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Client>(HiveBoxes.client).listenable(),
          builder: (context, Box<Client> box, _) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0.w, left: 20.0.w),
                child: Column(
                  children: [
                    Container(
                      width: 370.w,
                      child: Text(
                        "Select a client",
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                                final currentIndex = box.length - index - 1;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: 4.h,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (widget.is_pre_order) {
                                        Navigator.of(
                                          context,
                                        ).pushNamed(info_client_page,
                                            arguments: box.getAt(currentIndex));
                                      } else {
                                        Box<Order> contactsBox =
                                            Hive.box<Order>(HiveBoxes.order);
                                        Order? currentOrder = contactsBox
                                            .getAt(contactsBox.length - 1);

                                        // Проверьте, существует ли текущий порядок
                                        if (currentOrder != null) {
                                          // Полный список задач (если он есть, иначе создайте новый)

                                          // Создайте новый объект Tasks с обновленным списком задач
                                          currentOrder.client =
                                              box.getAt(currentIndex);

                                          // Обновите Order в box
                                          contactsBox.putAt(
                                              contactsBox.length - 1,
                                              currentOrder);
                                        }
                                        Navigator.of(
                                          context,
                                        ).pushNamed(order_page);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 89, 81, 246),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r))),
                                      child: Container(
                                        width: 400.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          color:
                                              Color.fromARGB(255, 89, 81, 246),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 12.w, right: 12.w),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  box
                                                      .getAt(currentIndex)!
                                                      .client_name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 16.sp),
                                                ),
                                              ),
                                              box.getAt(currentIndex)!.constants
                                                  ? Positioned(
                                                      top: 0,
                                                      right: 30.w,
                                                      child: Container(
                                                        width: 120.w,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .deepOrange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.r),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10.r),
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "Regular",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    14.sp),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    Expanded(child: Container()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(
                            add_client_page,
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
