// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/user_bloc/user_bloc.dart';
import 'package:lamie_middle_east_machine_task/network/shared_pref/sharedpref.dart';
import 'package:lamie_middle_east_machine_task/util/constance/colors.dart';
import 'package:lamie_middle_east_machine_task/util/constance/text_style.dart';
import 'package:lamie_middle_east_machine_task/view/screen_home.dart';
import 'package:lamie_middle_east_machine_task/view/screen_login.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(UserTokenCheckingEvent());
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) => userLoginCheck(context, state),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Frame 2.png'))),
                ),
                Text(
                  'Chatfy',
                  style: AppText.largeDark,
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Transform.scale(
                  scale: .9,
                  child: const CircularProgressIndicator(
                      strokeWidth: 6, color: AppColor.grey),
                ),
              ),
            ],
          ))
        ]),
      ),
    );
  }

  userLoginCheck(BuildContext context, state) async {
    await Future.delayed(const Duration(seconds: 3));
    if (state is UserTokenFoundState) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenHome(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenLogin(),
      ));
    }
  }
}
