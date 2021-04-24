import 'package:intl/intl.dart';

class DateUtilsHelper {

  static final dateFormat = new DateFormat("yyyy-MM-dd HH:mm:ss.SSS");

  static timeStamp(){
    return dateFormat.format(DateTime.now()).toString() + "+0100";
  }
}