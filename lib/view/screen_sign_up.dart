import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/signup_bloc/signup_bloc.dart';
import 'package:lamie_middle_east_machine_task/util/snack_bar/snack_bar.dart';
import 'package:lamie_middle_east_machine_task/view/screen_login.dart';
import '../util/constance/text_style.dart';
import '../util/validation/form_validation.dart';
import '../widgets/comman/buttom_widget.dart';
import '../widgets/comman/divider_widget.dart';
import '../widgets/comman/signup_dialog.dart';
import '../widgets/comman/text_feild_widget.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  bool loadingCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Frame 2.png'))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign Up',
                    style: AppText.largeDark,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Create a new account',
                    style: AppText.smallLight,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: userNameController,
                    hintText: 'Username',
                    icon: Icons.person_outline_sharp,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: 'Email',
                    icon: Icons.mail_outline_rounded,
                    validator: (value) => Validations.emailValidation(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    isObscure: true,
                    textVisibility: true,
                    controller: passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_open_rounded,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    isObscure: true,
                    textVisibility: true,
                    controller: conPasswordController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock_open_rounded,
                    validator: (value) => Validations.conformPasswordValidation(
                        value, passwordController.text),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is SignupFailedState) {
                        loadingCheck = false;
                        CustomSnackBar.showSnackBar(
                            context, state.errorMessage);
                      } else if (state is SignupSuccessState) {
                        loadingCheck = false;
                        showDialog(
                          context: context,
                          builder: (context) => const SignupDialog(),
                        );
                      } else if (state is SignupLoadingState) {
                        loadingCheck = true;
                      } else if (state is SignupUserAlreadyExistState) {
                        loadingCheck = false;
                        CustomSnackBar.showSnackBar(
                            context, state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      return ButtonWidget(
                        colorCheck: true,
                        onpressFunction: () => signupFnc(
                            context,
                            emailController.text,
                            userNameController.text,
                            passwordController.text),
                        text: 'Sing Up',
                        borderCheck: false,
                        loadingCheck: loadingCheck,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DividerWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    loadingCheck: false,
                    colorCheck: false,
                    onpressFunction: () => Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => ScreenLogin())),
                    text: 'Sing in',
                    borderCheck: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signupFnc(
      BuildContext context, String mail, String name, String password) async {
    if (signUpFormKey.currentState!.validate()) {
      context.read<SignupBloc>().add(SignupUserEvent(map: {
            "email": mail,
            "username": name,
            "password": password,
            "password2": password,
            "is_google": false
          }));
    }
  }
}
