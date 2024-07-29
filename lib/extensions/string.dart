import 'package:intl/intl.dart';

extension NumberParsing on dynamic {
  String cleanTextFieldInputNumber(String s) => s.replaceAll(RegExp(r'\D'), '');
  String formattedNumber(int s) =>
      NumberFormat('#,###', 'en_US').format(s).replaceAll(',', '.');
}
