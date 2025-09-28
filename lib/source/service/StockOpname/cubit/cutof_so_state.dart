part of 'cutof_so_cubit.dart';

@immutable
sealed class CutofSoState {}

final class CutofSoInitial extends CutofSoState {}

final class CutofSoLoading extends CutofSoState {}

final class CutofSoFailed extends CutofSoState {
  final int? statusCode;
  final dynamic json;

  CutofSoFailed({required this.statusCode, required this.json});
}

final class CutofSoLoaded extends CutofSoState {
  final int? statusCode;
  final List<ModelCutOf>? model;

  CutofSoLoaded({required this.statusCode, required this.model});
}
