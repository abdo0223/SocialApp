import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';
import 'package:shop_app/social_app/social_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                                  'https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/92843858_2884389024949894_717683954215288832_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=8bfeb9&_nc_eui2=AeG_ik3uUBCrch2k_foiskNJTAf5j230jRlMB_mPbfSNGW1y09iHIz3EVlTgHSF8_AWGsVGwfQJPwmS2qh7g9jV2&_nc_ohc=66kLxeTtMcwAX9rmc8h&tn=ZHh4De1E_Yb0YuH4&_nc_ht=scontent.fcai21-2.fna&oh=4d491a4f40872df3ffab9cd519fd6f19&oe=61417A96',
                                ),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                              Text(
                                'Communicate with friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.blue[900]),
                              ),
                            ]),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildListItem(context, cubit.posts[index], index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: cubit.posts.length)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListItem(context, PostModel post, int index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${post.image}',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${post.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${post.dateTime}',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text('${post.text}',
                  style: Theme.of(context).textTheme.subtitle1),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#software',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.amber,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#FlutterApp',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.amber,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (post.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${post.postImage}',
                            ),
                          ))),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        child: Row(
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: Colors.amber,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            // Text('${SocialCubit.get(context).postsLikes[index]}')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat,
                              size: 14,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Comments',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).model.image}',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'New Comment...',
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.headset,
                            color: Colors.amber,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Like')
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

class EditUserDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        nameController.text = SocialCubit.get(context).model.name;
        phoneController.text = SocialCubit.get(context).model.phone;
        bioController.text = SocialCubit.get(context).model.bio;
        var profileimage = SocialCubit.get(context).profileImage;
        var coverimage = SocialCubit.get(context).coverImage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            actions: [
              Center(
                child: InkWell(
                  onTap: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingImageState)
                    LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingImageState)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 290,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 240,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: coverimage != null
                                            ? FileImage(coverimage)
                                            : NetworkImage(
                                                '${SocialCubit.get(context).model.cover}',
                                              ) as ImageProvider,
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.grey[100].withOpacity(0.5),
                                  child: InkWell(
                                    onTap: () {
                                      SocialCubit.get(context).profileImage();
                                    },
                                    child: Icon(
                                      Icons.camera,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 94,
                              child: CircleAvatar(
                                radius: 90,
                                backgroundImage: profileimage != null
                                    ? FileImage(profileimage)
                                    : NetworkImage(
                                        '${SocialCubit.get(context).model.image}',
                                      ) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    Colors.grey[100].withOpacity(0.9),
                                child: InkWell(
                                  onTap: () {
                                    //   SocialCubit.get(context).pickProfilePic();
                                  },
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                SocialCubit.get(context).uploadProfile(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                              child: Text('upload profile image ',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RaisedButton(
                              onPressed: () {},
                              child: Text('upload cover image ',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              labelText: 'Name',
                              hintText: "Your Name",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        TextFormField(
                          controller: bioController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              labelText: 'Bio',
                              hintText: "Bio...",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              labelText: 'Phone',
                              hintText: "Your Phone",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewsFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).model != null
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        margin: EdgeInsets.all(
                          8.0,
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage(
                                '${SocialCubit.get(context).model.cover}',
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'communicate with friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(context,
                            SocialCubit.get(context).posts[index], index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.0,
                        ),
                        itemCount: SocialCubit.get(context).posts.length,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget buildPostItem(context, post, index) {
    DateTime date = DateTime.tryParse(post.dateTime);
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${post.image}',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${post.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        '${DateFormat.yMMMMEEEEd().format(date)}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${post.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            /* Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 5.0,
                ),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 6.0,
                        ),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: defaultColor,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 6.0,
                        ),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#flutter',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: defaultColor,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            SizedBox(
              height: 15.0,
            ),
            if (post.postImage != "")
              Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${post.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.headset,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Likes',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${post.image}',
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.caption.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.headset,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
