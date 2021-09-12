class SocilaUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String cover;

  bool isEmailVerified;
  String image;
  String bio;

  SocilaUserModel({
    this.email,
    this.cover,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.image,
    this.bio,
  });
  SocilaUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    cover = json['cover'];

    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];

    image = json['image'];

    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
      'image': image,
      'uId': uId,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
    };
  }
}

class PostModel {
  String name;
  String image;
  String uId;
  String dateTime;

  bool isEmailVerified;
  String text;
  String postImage;

  PostModel({
    this.postImage,
    this.name,
    this.dateTime,
    this.uId,
    this.text,
    this.isEmailVerified,
    this.image,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    text = json['text'];

    name = json['name'];
    postImage = json['postImage'];
    uId = json['uId'];

    image = json['image'];

    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'name': name,
      'dateTime': dateTime,
      'image': image,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
