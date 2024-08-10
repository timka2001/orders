import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_app/boxes.dart';
import 'package:flutter_test_app/data/clients.dart';
import 'package:flutter_test_app/data/orders.dart';
import 'package:flutter_test_app/data/tasks.dart';
import 'package:flutter_test_app/pages/info_order_page.dart';
import 'package:flutter_test_app/navigation/navigation.dart';
import 'package:flutter_test_app/pages/order_page.dart';
import 'package:flutter_test_app/pages/add_task_page.dart';
import 'package:flutter_test_app/pages/add_client_page.dart';
import 'package:flutter_test_app/pages/add_order_page.dart';
import 'package:flutter_test_app/pages/preview_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(ClientAdapter());
  Hive.registerAdapter(TasksAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Order>(HiveBoxes.order);
  await Hive.openBox<Client>(HiveBoxes.client);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: NavigationApp.generateRoute,
            title: 'Flutter Demo',
            theme: ThemeData(),
          );
        });
  }
}
