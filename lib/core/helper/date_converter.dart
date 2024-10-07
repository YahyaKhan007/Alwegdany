import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String formatValidityDate(String dateString){
    var inputDate=DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    var outputFormat=DateFormat('dd MMM yyyy').format(inputDate);
    return outputFormat;
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }
  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }


  static String isoStringToLocalDateAndTime(String dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm aa').format(isoStringToLocalDate(dateTime));
  }
  static String localDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toUtc());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static String getSubtractTime(String time,{ bool numericDates=false}){

    final date1 = DateTime.now();
    final isoDate = isoStringToLocalDate(time);
    final difference = date1.difference(isoDate);

    if ((difference.inDays / 365).floor() >= 1) {
      int year = (difference.inDays/365).floor();
      return '$year year ago';
    }else if((difference.inDays / 30).floor() >= 1){
      int month = (difference.inDays/30).floor();
      return '$month month ago';
    }
    else if((difference.inDays / 7).floor() >= 1){
      int week = (difference.inDays/7).floor();
      return '$week week ago';
    }
    else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    }  else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    }  else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }

  }

}