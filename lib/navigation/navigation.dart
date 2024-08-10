import 'package:flutter/material.dart';
import 'package:flutter_test_app/data/clients.dart';
import 'package:flutter_test_app/info_client_page.dart';
import 'package:flutter_test_app/pages/client_page.dart';
import 'package:flutter_test_app/pages/info_order_page.dart';
import 'package:flutter_test_app/pages/order_page.dart';
import 'package:flutter_test_app/pages/add_client_page.dart';
import 'package:flutter_test_app/pages/add_order_page.dart';
import 'package:flutter_test_app/pages/add_task_page.dart';
import 'package:flutter_test_app/pages/preview_page.dart';
import 'package:flutter_test_app/pages/statistics_page.dart';

const String add_client_page = "/add-client-page";
const String add_order_page = "/add-order-page";
const String add_task_page = "/add-task-page";
const String preview_page = "/preview-page";
const String info_order_page = "/info-order-page";
const String order_page = "/order-page";
const String client_page = "/client-page";
const String statistics_page = "/statistics-page";
const String info_client_page = "/info-client-page";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case add_client_page:
        return MaterialPageRoute(
          builder: (_) {
            return AddClientPage();
          },
          settings: settings,
        );
      case add_order_page:
        return MaterialPageRoute(
          builder: (_) {
            return AddOrderPage();
          },
          settings: settings,
        );
      case add_task_page:
        return MaterialPageRoute(
          builder: (_) {
            return AddTaskPage();
          },
          settings: settings,
        );
      case preview_page:
        return MaterialPageRoute(
          builder: (_) {
            return PreviewPage();
          },
          settings: settings,
        );
      case info_order_page:
        return MaterialPageRoute(
          builder: (_) {
            var args = settings.arguments as int;
            return InfoOrderPage(
              index: args,
            );
          },
          settings: settings,
        );
      case order_page:
        return MaterialPageRoute(
          builder: (_) {
            return OrderPage();
          },
          settings: settings,
        );
      case client_page:
        var args =
            settings.arguments == null ? false : settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) {
            return ClientPage(
              is_pre_order: args,
            );
          },
          settings: settings,
        );
      case statistics_page:
        var args = settings.arguments as List<int>;
        return MaterialPageRoute(
          builder: (_) {
            return StatisticsPage(
              list: args,
            );
          },
          settings: settings,
        );
      case info_client_page:
        var args = settings.arguments as Client;
        return MaterialPageRoute(
          builder: (_) {
            return InfoClientPage(
              client: args,
            );
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return OrderPage();
          },
          settings: settings,
        );
    }
  }
}
