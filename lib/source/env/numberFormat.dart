import 'package:intl/intl.dart';

String formatRupiah(int number) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '',
    decimalDigits: 0,
  );
  return formatter.format(number);
}