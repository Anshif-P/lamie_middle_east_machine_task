import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/google_signin_bloc/google_signin_bloc.dart';
import 'package:lamie_middle_east_machine_task/util/constance/colors.dart';
import 'package:lamie_middle_east_machine_task/util/snack_bar/snack_bar.dart';
import 'package:lamie_middle_east_machine_task/view/screen_login.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleSigninBloc, GoogleSigninState>(
      listener: (context, state) {
        if (state is GoogleSignOutSuccessState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ScreenLogin(),
          ));
        } else if (state is GoogleSignOutFailedState) {
          Navigator.of(context).pop();
          CustomSnackBar.showSnackBar(context, 'somthing went wrong');
        }
      },
      child: AlertDialog(
        title: const Text(
          'Sign Out ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Do you want to sign out',
          style: TextStyle(color: Color(0xFF6D6D6D)),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<GoogleSigninBloc>().add(GoogleUserSignOutEvent());
            },
            child: const Text(
              'Sign out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}
