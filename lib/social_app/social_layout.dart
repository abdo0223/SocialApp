import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';
import 'package:shop_app/social_app/new_post.dart/post_screen.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SocialNewPostState) {
        navigateAndEnd(context, NewPostScreen());
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.notification_important), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeBottomNav(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add_outlined), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on_rounded), label: 'location'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'setting'),
          ],
        ),
      );
    });
  }
}
