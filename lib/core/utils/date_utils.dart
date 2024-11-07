import 'package:intl/intl.dart';

extension DateEx on DateTime {
  //String get toFormattedDate => '$day / $month / $year';
  String get toFormattedDate {
    DateFormat formatter = DateFormat('dd / MM / yyyy');
    return formatter.format(this);
  }

  // String get dayName {
  //   List<String> days = ['MON', 'TUE', 'WED', 'THS', 'FRI', 'SAT', 'SUN'];
  //   return days[weekday - 1];
  // }

  String get getDayName {
    DateFormat formatter = DateFormat('E'); // view day name
    return formatter.format(this);
  }
}

String getDayName(DateTime date) {
  DateFormat formatter = DateFormat('E'); // view day name
  return formatter.format(date); //
}
