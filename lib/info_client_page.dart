import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/data/clients.dart';

class InfoClientPage extends StatelessWidget {
  InfoClientPage({required this.client});
  final Client client;

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
                  "Clients",
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
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
            child: Container(
              width: 400.w,
              child: Text(
                client.client_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
            child: Container(
              width: 400.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: client.constants
                    ? Colors.deepOrange
                    : Color.fromARGB(255, 183, 192, 251),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Priority order",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w, top: 10.0.w),
            child: Container(
              width: 340.w,
              child: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
          ),
          Padding(
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
                  client.client_description,
                  maxLines: 10,
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),
                ),
              ),
            ),
          ),
          Padding(
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
                      "Phone:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    Text(
                      client.phone,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
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
                      "E-Mail:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    Text(
                      client.mail,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
