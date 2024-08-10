import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/orders.dart';
import 'package:hive/hive.dart';

class InfoOrderPage extends StatefulWidget {
  InfoOrderPage({super.key, required this.index}) {}
  final int index;
  @override
  _InfoOrderPageState createState() => _InfoOrderPageState();
}

class _InfoOrderPageState extends State<InfoOrderPage> {
  ScrollController _controller = ScrollController();

  double _appBarOpacity = 0.0; // Initial opacity of the AppBar
  double _appLeadingOpacity = 1.0; // Initial opacity of the AppBar
  Order _order = Order();

  @override
  void initState() {
    super.initState();
    Box<Order> contactsBox = Hive.box<Order>(HiveBoxes.order);
    _order = contactsBox.getAt(widget.index)!;
    _controller.addListener(() {
      // Update the AppBar opacity based on scroll position
      double newOpacity = _controller.position.pixels > 60
          ? 1.0
          : (_controller.position.pixels / 60);
      if (newOpacity != _appBarOpacity) {
        setState(() {
          _appBarOpacity = newOpacity.clamp(0.0, 1.0);
          _appLeadingOpacity = 1.0 - _appBarOpacity;
          print(_appBarOpacity);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _order.order_name,
            style: TextStyle(color: Colors.black.withOpacity(_appBarOpacity)),
          ),
          leadingWidth: 100.w,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue.withOpacity(_appLeadingOpacity),
                  ),
                  Text(
                    "My orders",
                    style: TextStyle(
                        color: Colors.blue.withOpacity(_appLeadingOpacity)),
                  )
                ],
              ),
            ),
          ),
          backgroundColor:
              Color.fromARGB(255, 89, 81, 246).withOpacity(_appBarOpacity)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 20.0.w, left: 20.0.w),
          child: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                    width: 400.w,
                    child: Text(
                      _order.order_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.sp),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                    width: 400.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: _order.priority
                          ? Colors.deepOrange
                          : Color.fromARGB(255, 183, 192, 251),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Priority order",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, top: 10.0.w),
                  child: Container(
                    width: 340.w,
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                    width: 400.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color.fromARGB(255, 183, 192, 251),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Text(
                        _order.order_description,
                        maxLines: 10,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                    width: 400.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color.fromARGB(255, 183, 192, 251),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Difficulty:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          Text(
                            _order.difficulty,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                    width: 400.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color.fromARGB(255, 183, 192, 251),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deadline:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          Text(
                            _order.order_date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, top: 10.0.w),
                  child: Container(
                    width: 340.w,
                    child: Text(
                      "Tasks",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                      width: 400.w,
                      child: Column(
                        children: _order.tasks!.task.map((toElement) {
                          return Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                            child: Container(
                              width: 400.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                color: Color.fromARGB(255, 89, 81, 246),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0.w, right: 8.0.w),
                                    child: Text(
                                      "${toElement.task_name}:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0.w, right: 8.0.w),
                                    child: Text(
                                      "${toElement.price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, top: 10.0.w),
                  child: Container(
                    width: 340.w,
                    child: Text(
                      "Client",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: Container(
                    width: 400.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color.fromARGB(255, 89, 81, 246),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _order.client!.client_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16.sp),
                            ),
                          ),
                          _order.client!.constants
                              ? Positioned(
                                  top: 0,
                                  right: 30.w,
                                  child: Container(
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r),
                                        )),
                                    child: Center(
                                      child: Text(
                                        "Regular",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14.sp),
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
              SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0.w, top: 10.0.w),
                    child: SizedBox(
                      height: 20.h,
                    )),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      Box<Order> contactsBox = Hive.box<Order>(HiveBoxes.order);
                      contactsBox.deleteAt(widget.index);
                      Navigator.of(
                        context,
                      ).pop();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 170.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.r),
                                ),
                                color: Colors.deepOrange),
                            child: Center(
                              child: Text(
                                "Remove",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.sp),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!_order.isComplte) {
                                Box<Order> contactsBox =
                                    Hive.box<Order>(HiveBoxes.order);
                                _order.isComplte = true;
                                contactsBox.putAt(widget.index, _order);
                              }
                              Navigator.of(
                                context,
                              ).pop();
                            },
                            child: Container(
                              width: 170.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.r),
                                  ),
                                  color: Colors.deepOrange),
                              child: Center(
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
