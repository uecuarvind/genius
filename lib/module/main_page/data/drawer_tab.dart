import 'package:flutter/material.dart';

class DrawerTab{
  String title;
  IconData icon;
  List<SubTab> tabs;
  String? route;
  dynamic arguments;

  DrawerTab({required this.title, required this.icon, required this.tabs, this.route,this.arguments});
}
class SubTab{
  String title;
  String? route;
  dynamic arguments;

  SubTab({required this.title, this.route,this.arguments});
}