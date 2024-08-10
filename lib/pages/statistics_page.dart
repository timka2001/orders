import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({required this.list});
  final List<int> list;
  List<String> name = [
    "Earn for all time:",
    "Completed for all time:",
    "Number of clients\nfor all time"
  ];
  int i = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  color: Colors.blue,
                ),
                Text(
                  "My orders",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(right: 20.0.w, left: 20.0.w),
        child: Column(
          children: [
            Container(
              width: 370.w,
              child: Text(
                "Statistics",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: list.map((toElement) {
                i++;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    width: 360.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Color.fromARGB(255, 89, 81, 246),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 180.w,
                          height: 90.h,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              name[i],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 180.w,
                            height: 90.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60.r),
                                bottomLeft: Radius.circular(60.r),
                                topRight: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              ),
                              color: Colors.deepOrange,
                            ),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "${toElement}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      )),
    );
  }
}
