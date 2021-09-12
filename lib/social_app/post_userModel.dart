class PostUserModel {
  String name;

  String uId;

  String image;
  String date;
  String text;
  String postImage;
  PostUserModel({
    this.name,
    this.uId,
    this.image,
  });
  PostUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    date = json['date'];
    postImage = json['postImage'];
    text = json['text'];

    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'uId': uId,
      'image': image,
      'text': text,
    };
  }
}

class PostModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}

class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;
  String cover;
  String bio;
  bool isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
