import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/google_signin_bloc/google_signin_bloc.dart';
import 'package:lamie_middle_east_machine_task/controller/login_bloc/login_bloc.dart';
import 'package:lamie_middle_east_machine_task/util/constance/text_style.dart';
import 'package:lamie_middle_east_machine_task/util/snack_bar/snack_bar.dart';
import 'package:lamie_middle_east_machine_task/view/screen_home.dart';
import 'package:lamie_middle_east_machine_task/view/screen_sign_up.dart';
import 'package:lamie_middle_east_machine_task/widgets/comman/buttom_widget.dart';
import 'package:lamie_middle_east_machine_task/widgets/comman/divider_widget.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../util/validation/form_validation.dart';
import '../widgets/comman/text_feild_widget.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool loadingCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: loginFormKey,
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
                        image: AssetImage('assets/images/Frame 2.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome To Chatfy',
                    style: AppText.largeDark,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign in to Continue',
                    style: AppText.smallLight,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: 'Email',
                    icon: Icons.account_circle_outlined,
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
                    icon: Icons.lock_open_outlined,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget Password?',
                        style: AppText.smallDark,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: false,
                        onChanged: (value) {},
                      ),
                      Text(
                        'Remeber me and keep me logged in',
                        style: AppText.smallGrey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        loadingCheck = false;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ScreenHome(),
                          ),
                        );
                      } else if (state is LoginFailedState) {
                        loadingCheck = false;
                        CustomSnackBar.showSnackBar(
                            context, state.errorMessage);
                      } else if (state is LoginLoadingState) {
                        loadingCheck = true;
                      }
                    },
                    builder: (context, state) {
                      return ButtonWidget(
                        colorCheck: true,
                        onpressFunction: () => loginFnc(
                          context,
                          emailController.text,
                          passwordController.text,
                        ),
                        text: 'Sing in',
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
                    onpressFunction: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ScreenSignUp(),
                    )),
                    text: 'Sing Up',
                    borderCheck: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: BlocConsumer<GoogleSigninBloc, GoogleSigninState>(
                      listener: (context, state) {
                        if (state is GoogleSigninSuccessState) {
                          context.read<GoogleSigninBloc>().add(
                                  PassLoginDetailsToApiEvent(map: {
                                'email': state.email,
                                'access_token': state.accessToken
                              }));
                        } else if (state is GoogleSigninFailedState) {
                          loadingCheck = false;
                          CustomSnackBar.showSnackBar(
                              context, state.errorMessage);
                        } else if (state is LoginLoadingState) {
                          loadingCheck = true;
                        } else if (state is PassLoginDetailsToApiSuccessState) {
                          loadingCheck = false;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ScreenHome(),
                            ),
                          );
                        } else if (state is PassLoginDetailsToApiFailedState) {
                          loadingCheck = false;
                          CustomSnackBar.showSnackBar(
                              context, state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is GoogleSigninLoadingState) {
                          return const CircleAvatar(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SignInButton(
                          text: 'Sign in with Google',
                          Buttons.google,
                          onPressed: () {
                            signInWithGoogle(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginFnc(BuildContext context, String mail, String password) async {
    if (loginFormKey.currentState!.validate()) {
      context
          .read<LoginBloc>()
          .add(LoginUserEvent(map: {"email": mail, "password": password}));
    }
  }

  signInWithGoogle(BuildContext context) {
    context.read<GoogleSigninBloc>().add(GoogleUserSigninEvent());
  }
}
