part of 'location_so_cubit.dart';

@immutable
sealed class LocationSoState {}

final class LocationSoInitial extends LocationSoState {}

final class LocationSoLoading extends LocationSoState {}

final class LocationSoFailed extends LocationSoState {
  final int? statusCode;
  final dynamic json;

  LocationSoFailed({required this.statusCode, required this.json});
}

final class LocationSoListLoaded extends LocationSoState {
  final int? statusCode;
  final List<ModelLocationCodeSoList>? model;

  LocationSoListLoaded({required this.statusCode, required this.model});
}

final class LocationSoCodeLoaded extends LocationSoState {
  final int? statusCode;
  final ModelLocationCodeSo? model;

  LocationSoCodeLoaded({required this.statusCode, required this.model});
}
