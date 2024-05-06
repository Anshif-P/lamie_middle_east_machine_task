import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lamie_middle_east_machine_task/repositories/authentication_repo.dart';

import '../../network/shared_pref/sharedpref.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(loginUserEvent);
  }

  FutureOr<void> loginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final either = await AuthenticationRepo().loginUserFnc(event.map);
    either.fold((error) => emit(LoginFailedState(errorMessage: error.message)),
        (response) {
      if (response['detail'] !=
          'No active account found with the given credentials') {
        SharedPrefModel.instance.insertData('token', response['access']);
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(response['access']);
        print(
            '--------------------------------------- ****************88999999999$decodedToken');
        SharedPrefModel.instance.isertUserId('userId', decodedToken['user_id']);
        emit(LoginSuccessState());
      } else {
        emit(LoginFailedState(errorMessage: 'somthing went wrong'));
      }
    });
  }
}
