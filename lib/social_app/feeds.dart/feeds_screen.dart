import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';

import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';
import 'package:shop_app/social_app/social_model.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 &&
              SocialCubit.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 10.0,
                  child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://lh3.googleusercontent.com/pw/AM-JKLWVBTcMkN3RCbNzowOkeOXxKTAU6WBjZ_NbOEsrTtWlJTNJG4jJEATR9rKJDWFj-uRvh7GRkb4UuPbt5JYOCwrGYOCgRK4reQF8Mlrf2w0hLbpPiQw-RFzmh2aGpUr8UuvSJdp9PuGSNWwb6gkgNNCJ=w1408-h933-no'),
                          fit: BoxFit.cover,
                          height: 220.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Communicate\n With Friends',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ]),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildPostItem(
                        SocialCubit.get(context).posts[index], context, index);
                  },
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(
    PostModel model,
    context,
    index,
  ) =>
      Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 6.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.image}'),
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
                              '${model.name}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    iconSize: 22.0,
                    icon: Icon(Icons.more_horiz_rounded),
                    onPressed: () {},
                  )
                ],
              ), //handelling my avatar
              myDivider(),
              SizedBox(
                height: 4,
              ),
              Text(
                '${PostModel().text}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), //كلام البوست
              SizedBox(
                height: 4,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 10,
              //       bottom: 5.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6.0),
              //           child: Container(
              //             height: 20.0,
              //             child: MaterialButton(
              //               onPressed: (){},
              //               height:25 ,
              //               minWidth:1 ,
              //               padding: EdgeInsets.zero,
              //               child: Text('#Software',
              //                 style: TextStyle(color: Colors.blue),),
              //
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6.0),
              //           child: Container(
              //             height: 20.0,
              //             child: MaterialButton(
              //               onPressed: (){},
              //               height:25 ,
              //               minWidth:1 ,
              //               padding: EdgeInsets.zero,
              //               child: Text('#Flutter',
              //                 style: TextStyle(color: Colors.blue),),
              //
              //             ),
              //           ),
              //         ),
              //
              //
              //       ],
              //     ),
              //   ),
              // ),//التاجز
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: NetworkImage(
                            '${model.postImage}',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ), //صوره البوست
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.hearing,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '1',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.message,
                                size: 18,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0 Comment',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ), //عدد اللايكات
              myDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        NetworkImage('${SocialCubit.get(context).model.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                      flex: 5,
                      child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Write a comment ...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ))),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ' Like',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[index]);
                        print('ack');
                      },
                    ),
                  ),
                ],
              ),
              myDivider(),
            ],
          ),
        ),
      );
}
