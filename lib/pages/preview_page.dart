import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/navigation/navigation.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({
    super.key,
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 800.h,
        color: Color.fromARGB(255, 89, 81, 246),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  height: 400.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/web-development.png"))),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "Create your\nfirst order",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Text(
                  "Create your first order,specify the deadline\n,complexity of the work,priority and\n description of the task.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(order_page);
                },
                child: Container(
                  height: 50.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(20.r))),
                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
