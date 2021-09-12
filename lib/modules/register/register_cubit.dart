import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/social_app/social_model.dart';
import 'package:shop_app/modules/register/shop_login_model.dart';
import 'package:shop_app/modules/register/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/social_app/social_login_screen/cubit/states.dart';
import 'package:shop_app/social_app/social_register_screen/cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/social_app/social_register_screen/cubit/register_states.dart';

class SocialRegisterCubit extends Cubit<RegisterStates> {
  SocialRegisterCubit() : super(RegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterInitialState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
    });
    void userCreate({
      @required String email,
      @required String name,
      @required String phone,
      @required String uId,
    }) {
      SocilaUserModel model = SocilaUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap())
          .then((value) {
        userCreate(email: email, name: name, phone: phone, uId: uId);
        // emit((RegisterSuccessState()));
      }).catchError((error) {
        emit(RegisterErrorState(error.toString()));
      });
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStates());
  }
}
