part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authloading extends AuthState {}

final class Authloaded extends AuthState {
  final int? statusCode;
  final dynamic json;

  Authloaded({required this.statusCode, required this.json});
}