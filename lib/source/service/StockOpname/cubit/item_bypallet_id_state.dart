part of 'item_bypallet_id_cubit.dart';

@immutable
sealed class ItemBypalletIdState {}

final class ItemBypalletIdInitial extends ItemBypalletIdState {}

final class ItemBypalletIdLoading extends ItemBypalletIdState {}

final class ItemBypalletIdFailed extends ItemBypalletIdState {
  final int? statusCode;
  final dynamic json;

  ItemBypalletIdFailed({required this.statusCode, required this.json});
}

final class ItemBypalletIdLoaded extends ItemBypalletIdState {
  final int? statusCode;
  final ModelItembyPalletId? model;

  ItemBypalletIdLoaded({required this.statusCode, required this.model});
}
