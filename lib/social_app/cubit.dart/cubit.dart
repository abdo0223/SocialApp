import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/social_app/chats.dart/chats_screen.dart';
import 'package:shop_app/social_app/cubit.dart/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/social_app/feeds.dart/feeds_screen.dart';
import 'package:shop_app/social_app/new_post.dart/post_screen.dart';
import 'package:shop_app/social_app/settings.dart/settings_screen.dart';
import 'package:shop_app/social_app/social_model.dart';
import 'package:shop_app/social_app/social_register_screen/cubit/register_states.dart';
import 'package:shop_app/social_app/users.dart/users_screen.dart';
import 'package:shop_app/social_app/cubit.dart/cubit.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  get profileImage => null;

  static SocialCubit get(context) => BlocProvider.of(context);

  SocilaUserModel model;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    uId = CacheHelper.getData(key: 'uId');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocilaUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUsererrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File image;
  var picker = ImagePicker();
  Future<void> getprofileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);

      image = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      emit(SocialProfileImageErrorState());

      print('No image');
    }
  }

  File coverImage;
  Future<void> getcoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(SocialCoverImageSuccessState());
      image = File(pickedFile.path);
    } else {
      emit(SocialCoverImageErrorState());

      print('No image');
    }
  }

  void uploadProfile({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdateLoadingImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageErrorState());
    });
  }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    emit(SocialUserUpdateLoadingState());
    SocilaUserModel userModel = SocilaUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: model.email,
        image: image ?? model.image,
        uId: uId,
        cover: cover ?? model.cover,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
      emit(SocialUserUpdateSuccessState());
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File postImage;
  var pickere = ImagePicker();
  Future<void> getpostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);

      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      emit(SocialPostImageErrorState());

      print('No image');
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      SocialGetPostserrorState(error.toString());
    });
  }

  void creatPost({
    @required String dataTime,
    @required String text,
    String postModel,
  }) {
    PostModel userModel = PostModel(
      dateTime: dataTime,
      name: model.name,
      image: model.image,
      text: text,
      uId: model.uId,
      postImage: image ?? '',
    );
  }

  void uploadPostImage({
    @required String text,
    @required String datetime,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadImageSuccessState());
        print(value);
        createPost(text: text, datetime: datetime, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    @required String text,
    @required String datetime,
    String postImage,
  }) {
    PostModel userModel = PostModel(
      name: model.name,
      image: model.image,
      uId: model.uId,
      dateTime: datetime,
      text: text,
      postImage: postImage,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });

    List<PostModel> posts = [];
    List<String> postsId = [];
    List<int> likes = [];

    void getPosts() {
      FirebaseFirestore.instance.collection('posts').get().then((value) {
        value.docs.forEach((element) {
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
          }).catchError((error) {});
        });
        emit(SocialGetPostsSuccessState());
      }).catchError((error) {
        emit(SocialGetPostserrorState(error.toString()));
      });
    }
  }

  List<String> postsId = [];

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      SocialLikePosterrorState(error.toString());
    });
  }
}
