part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailedState extends SignupState {
  String errorMessage;
  SignupFailedState({required this.errorMessage});
}

final class SignupUserAlreadyExistState extends SignupState {
  final String errorMessage;
  SignupUserAlreadyExistState({required this.errorMessage});
}

final class SignupLoadingState extends SignupState {}
