import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/home_screen/home_layout.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/modules/register/register_cubit.dart';
import 'package:shop_app/modules/register/register_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/social_app/social_layout.dart';
import 'package:shop_app/social_app/social_register_screen/cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndEnd(context, SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'please enter your Name',
                          controller: nameController,
                          inputType: TextInputType.name,
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
                        ),
                        SizedBox(
                          height: 20.0,
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
                          suffixIcon: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isObsecured:
                              SocialRegisterCubit.get(context).isPasswordShown,
                          labelText: 'Password',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'please enter your Phone Number',
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone Number',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              string: 'REGISTER',
                              function: () {
                                if (formKey.currentState.validate()) {
                                  print(emailController.text);
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                ;
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
                              'You have an account ? ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndEnd(context, LoginScreen());
                              },
                              child: Text(
                                'LOGIN',
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
              ),
            ),
          );
        },
      ),
    );
  }
}
