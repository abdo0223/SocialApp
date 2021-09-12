import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/shop_login_model.dart';
import 'package:shop_app/social_app/social_model.dart';

import 'package:shop_app/social_app/social_register_screen/cubit/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user.uid,
      );
    }).catchError((onError) {
      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

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
        bio: 'Write Your Bio....',
        image:
            'https://storage.googleapis.com/nogoumfm-eu-web/1/2019/10/Untitled-1-75.jpg',
        cover:
            'https://storage.googleapis.com/nogoumfm-eu-web/1/2019/10/Untitled-1-75.jpg',
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError) {
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityStates());
  }
}
