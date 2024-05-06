part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupUserEvent extends SignupEvent {
  final Map map;
  SignupUserEvent({required this.map});
}
