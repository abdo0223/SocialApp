import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var textController = TextEditingController();
        var postimage = SocialCubit.get(context).image;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'create post',
            actions: [
              FlatButton(
                onPressed: () {
                  var now = DateTime.now();

                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      datetime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      datetime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/pw/AM-JKLWVBTcMkN3RCbNzowOkeOXxKTAU6WBjZ_NbOEsrTtWlJTNJG4jJEATR9rKJDWFj-uRvh7GRkb4UuPbt5JYOCwrGYOCgRK4reQF8Mlrf2w0hLbpPiQw-RFzmh2aGpUr8UuvSJdp9PuGSNWwb6gkgNNCJ=w1408-h933-no'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Container(
                      child: Text(
                        'abo abdo',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                      minLines: 1,
                      maxLines: 8,
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'What Is Your Mind....',
                          border: InputBorder.none,
                          focusColor: Colors.grey),
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(postimage)))),
                  ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  onPressed: () {
                    SocialCubit.get(context).getpostImage();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getpostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_aspect_ratio_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'Add photoo',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
