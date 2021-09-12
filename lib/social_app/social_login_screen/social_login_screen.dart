import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/home_screen/home_layout.dart';
import 'package:shop_app/social_app/social_layout.dart';
import 'package:shop_app/social_app/social_model.dart';

import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'package:shop_app/social_app/social_login_screen/cubit/cubit.dart';
import 'package:shop_app/social_app/social_login_screen/cubit/states.dart';
import 'package:shop_app/social_app/social_register_screen/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndEnd(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'login now to communication with friends ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                            validatorText: 'please enter your Email Address',
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email Address'),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'please enter your Password',
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: SocialLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isObsecured: SocialLoginCubit.get(context).isPassword,
                          labelText: 'Password',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                              string: 'LOGIN',
                              function: () {
                                if (formKey.currentState.validate()) {
                                  print(emailController.text);
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              color: Colors.purpleAccent),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
