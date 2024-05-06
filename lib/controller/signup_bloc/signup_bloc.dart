import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lamie_middle_east_machine_task/repositories/authentication_repo.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupUserEvent>(signupUserEvent);
  }

  FutureOr<void> signupUserEvent(
      SignupUserEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());
    final either = await AuthenticationRepo().signupFnc(event.map);
    either.fold((error) => emit(SignupFailedState(errorMessage: error.message)),
        (response) {
      if (response['status'] == 201) {
        emit(SignupSuccessState());
      } else if (response["status"] == 404) {
        emit(SignupUserAlreadyExistState(
            errorMessage: 'Email or Username Already exists'));
      } else {
        emit(SignupFailedState(errorMessage: 'somthing went wrong'));
      }
    });
  }
}
