// Function to convert DateTime to readable format in 12-hour format
import 'package:intl/intl.dart';

class MyDateTimeFormatter {
  static fTD(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd – h:mm a');
    return formatter.format(dateTime);
  }

// Function to convert ISO 8601 date string to readable format in 12-hour format
  // static String formatDateString(String isoDateString) {
  //   try {
  //     final DateTime dateTime = DateTime.parse(isoDateString);
  //     return fTD(dateTime);
  //   } catch (e) {
  //     return 'Invalid date';
  //   }
  // }
}
