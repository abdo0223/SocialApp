import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/home_screen/home_layout.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_app/social_app/constans.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/social_layout.dart';

import 'package:shop_app/social_app/social_login_screen/cubit/cubit.dart';
import 'package:shop_app/social_app/social_login_screen/social_login_screen.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
//  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  //print(onBoarding);

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    //  onBoarding: onBoarding,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool onBoarding;
  final Widget startWidget;

  const MyApp({this.onBoarding, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeDate()
              ..getCategoriesDate()
              ..getFavorites()
              ..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeData(
            primarySwatch: constants.color,
            accentColor: Color.fromRGBO(24, 193, 15, 1),
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: constants.color,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.purple)),
        home: startWidget,
      ),
    );
  }
}
