part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class UserTokenFoundState extends UserState {}

final class UserTokenNotFoundState extends UserState {}
