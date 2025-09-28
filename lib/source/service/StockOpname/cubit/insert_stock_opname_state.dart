part of 'insert_stock_opname_cubit.dart';

@immutable
sealed class InsertStockOpnameState {}

final class InsertStockOpnameInitial extends InsertStockOpnameState {}

final class InsertStockOpnameLoading extends InsertStockOpnameState {}

final class InsertStockOpnameFailed extends InsertStockOpnameState {
  final int? statusCode;
  final dynamic json;

  InsertStockOpnameFailed({required this.statusCode, required this.json});
}

final class InsertStockOpnameLoaded extends InsertStockOpnameState {
  final int? statusCode;
  final dynamic json;

  InsertStockOpnameLoaded({required this.statusCode, required this.json});
}
