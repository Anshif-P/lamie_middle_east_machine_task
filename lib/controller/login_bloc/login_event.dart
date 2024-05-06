part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final Map<String, dynamic> map;
  LoginUserEvent({required this.map});
}
