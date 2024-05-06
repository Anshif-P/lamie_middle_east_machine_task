import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lamie_middle_east_machine_task/network/shared_pref/sharedpref.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserTokenCheckingEvent>(userTokenCheckingEvent);
  }

  FutureOr<void> userTokenCheckingEvent(
      UserTokenCheckingEvent event, Emitter<UserState> emit) {
    final token = SharedPrefModel.instance.getData('token');
    if (token != null) {
      emit(UserTokenFoundState());
    } else {
      emit(UserTokenNotFoundState());
    }
  }
}
