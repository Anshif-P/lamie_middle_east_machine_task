import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/google_signin_bloc/google_signin_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/login_bloc/login_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/signup_bloc/signup_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/user_bloc/user_bloc.dart';
import 'package:lamie_middle_east_machine_task/network/shared_pref/sharedpref.dart';
import 'package:lamie_middle_east_machine_task/view/screen_splash.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefModel.instance.initSharedPref();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => GoogleSigninBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        )
      ],
      child: MaterialApp(
        home: ScreenSplash(),
      ),
    );
  }
}
