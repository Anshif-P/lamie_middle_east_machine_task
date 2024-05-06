part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginFailedState extends LoginState {
  final String errorMessage;
  LoginFailedState({required this.errorMessage});
}

final class LoginLoadingState extends LoginState {}
