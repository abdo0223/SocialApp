import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';

import 'package:shop_app/social_app/edit_profile.dart/edit_screen.dart';
import 'package:shop_app/social_app/edit_profile.dart/edit_screen.dart';

import 'package:shop_app/social_app/social_login_screen/cubit/aybtengan.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        )),
                        width: double.infinity,
                        child: Container(
                          child: Card(
                            elevation: 11,
                            margin: EdgeInsets.all(8),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      'https://i.ytimg.com/vi/1Izf1-5pju0/mqdefault.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 150,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '${userModel.name}',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text('${userModel.bio}',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.grey[500])),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '101',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '187',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Photos',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '10k',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '568',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('followings',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {},
                    elevation: 20,
                    child: Text('Edit Profile'),
                  ),
                  Spacer(),
                  OutlineButton(
                    onPressed: () {
                      navigateTo(context, EditProfile());
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
