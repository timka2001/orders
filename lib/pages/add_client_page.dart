import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/clients.dart';
import 'package:flutter_test_app/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddClientPage extends StatefulWidget {
  AddClientPage({
    super.key,
  });

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  ScrollController listscollcont = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  String regular = '';

  @override
  void initState() {
    super.initState();
    _updateFormCompletion();

    nameController.addListener(_updateFormCompletion);
    descriptionController.addListener(_updateFormCompletion);
    phoneController.addListener(_updateFormCompletion);
    mailController.addListener(_updateFormCompletion);
  }

  _updateFormCompletion() {
    bool isFilled = nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        mailController.text.isNotEmpty &&
        regular.isNotEmpty;
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
                          "Back",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      if (_updateFormCompletion()) {
                        Box<Client> contactsBox =
                            Hive.box<Client>(HiveBoxes.client);
                        Client addklietnt = Client(
                            client_name: nameController.text,
                            client_description: descriptionController.text,
                            phone: phoneController.text,
                            mail: mailController.text,
                            constants: regular == "Yes" ? true : false);
                        contactsBox.add(addklietnt);
                        Navigator.of(
                          context,
                        ).pop();
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: _updateFormCompletion()
                              ? Colors.blue
                              : Colors.red),
                    ))
              ]),
              Padding(
                padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w),
                child: Container(
                  width: 400.w,
                  child: Text(
                    "Add a new client",
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
                    "Phone number",
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
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Убираем обводку
                      focusedBorder:
                          InputBorder.none, // Убираем обводку при фокусе
                      hintText: '+X XXX XXX XX XX',
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      print(phoneController.value.text);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "E-mail",
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
                    controller: mailController,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Убираем обводку
                      focusedBorder:
                          InputBorder.none, // Убираем обводку при фокусе
                      hintText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      print(phoneController.value.text);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: Container(
                  width: 340.w,
                  child: Text(
                    "A regular customer?",
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
                          regular = toElement;
                          _updateFormCompletion();
                        });
                      },
                      child: Container(
                        width: 170.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: regular == toElement
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
}
