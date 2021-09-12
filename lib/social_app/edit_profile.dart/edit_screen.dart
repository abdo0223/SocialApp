import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  File image;
  var picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        var image = SocialCubit.get(context).image;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              OutlineButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: Text('Update',
                      style: TextStyle(color: Colors.blue[500]))),
              SizedBox(
                width: 30,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                  'https://i.ytimg.com/vi/1Izf1-5pju0/mqdefault.jpg',
                                                ),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 150,
                                              ),
                                              IconButton(
                                                icon: (Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: (Colors.white))),
                                                onPressed: () {},
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: CircleAvatar(
                                radius: 55,
                                backgroundImage: image == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(image)),
                          ),
                          IconButton(
                            icon: (Icon(Icons.camera_alt_outlined,
                                color: (Colors.white))),
                            onPressed: () {
                              SocialCubit.get(context).getprofileImage();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (SocialCubit.get(context).image != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).image != null)
                        Expanded(
                          child: Column(
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
                            ],
                          ),
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
                SizedBox(
                  height: 0,
                ),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      labelText: 'Name',
                      hintText: "Your Name",
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                TextFormField(
                  controller: bioController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      labelText: 'Bio',
                      hintText: "Bio...",
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      labelText: 'Phone',
                      hintText: "Your Phone",
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
