part of 'get_stock_opname_cubit.dart';

@immutable
sealed class GetStockOpnameState {}

final class GetStockOpnameInitial extends GetStockOpnameState {}

final class GetStockOpnameLoading extends GetStockOpnameState {}

final class GetStockOpnameFailed extends GetStockOpnameState {
  final int? statusCode;
  final dynamic json;

  GetStockOpnameFailed({required this.statusCode, required this.json});
}

final class GetStockOpnameLoaded extends GetStockOpnameState {}
