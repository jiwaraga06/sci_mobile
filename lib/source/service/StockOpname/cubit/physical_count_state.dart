part of 'physical_count_cubit.dart';

@immutable
sealed class PhysicalCountState {}

final class PhysicalCountInitial extends PhysicalCountState {}

final class PhysicalCountLoading extends PhysicalCountState {}

final class PhysicalCountFailed extends PhysicalCountState {
  final int? statusCode;
  final dynamic json;

  PhysicalCountFailed({required this.statusCode, required this.json});
}

final class PhysicalCountLoaded extends PhysicalCountState {
  final int? statusCode;
  final ModelPhysicalCount? model;

  PhysicalCountLoaded({required this.statusCode, required this.model});
}
