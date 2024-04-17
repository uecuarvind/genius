import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

enum ServerDateTime { Date, Time}


class Helper{

  static String getTime(String dateTime){
    DateTime time = DateTime.parse(dateTime);
    return '${time.hour.toString().padLeft(2,'0')}h${time.minute.toString().length==1 ? '0${time.minute}' : time.minute}';
  }

  static bool isToday(String date,{int inDay=0}){
    DateTime dateTime = DateTime.parse('${DateTime.now().toString().split(' ')[0]} 00:00:00');
    DateTime _pickedDate = DateTime.parse('${DateTime.parse(date).toString().split(' ')[0]} 00:00:00');
    return _pickedDate.difference(dateTime).inDays == inDay;
  }

  static bool isEmailValid(String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }


  static Future<String?> openDatePicker({String date=''}) async {
    DateTime selectedDate;
    try {
      selectedDate = date.isNotEmpty ? DateTime.parse(date) : DateTime.now();
    } catch (e) {
      selectedDate = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
        context: appContext,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      return AppConstant.defaultDateFormat.format(picked);
    } else {
      return null;
    }
  }

  static goBrowser(String? url) async {
    if(url == null) return;
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
  static makeCall(String number) async {
    if (!await launchUrl(Uri(scheme: 'tel', path: number,))) {
      throw 'Could not launch $number';
    }
  }

  static sendEmail(String email) async {
    if (!await launchUrl(Uri(scheme: 'mailto', path: email,))) {
      throw 'Could not launch $email';
    }
  }

  static copyText(String text) async {
    try{
      await Clipboard.setData(ClipboardData(text: text));
      SuccessMessage(message: appLanguage().copiedSuccessfully);
    } catch(e){}
  }

  static String generateString({int length = 10}){
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static isTimeInside({required String time, Duration? duration}) {
    DateTime dateTime = DateTime.now().add(duration ?? const Duration(milliseconds: 0));
    DateTime _pickedDate = DateTime.parse(time);
    return dateTime.difference(_pickedDate).inSeconds>=0;
  }

  static String getFormatDate(String format,String date){
    try{
      return DateFormat(format).format(DateTime.parse(date));
    } catch(e){
      return date;
    }
  }

  static Color getStatusColor(String status){
    switch(status.toLowerCase()){
      case 'pending':
        return Colors.yellow;
      case 'accepted':
        return Colors.lightGreen;
      case 'complete':
        return Colors.lightGreen;
      case 'completed':
        return Colors.lightGreen;
      case 'succeed':
        return Colors.lightGreen;
      case 'running':
        return Colors.lightGreen;
      case 'rejected':
        return Colors.redAccent;
      case 'paid':
        return Colors.blueAccent;
      default:
        return Colors.yellow;
    }
  }
}
