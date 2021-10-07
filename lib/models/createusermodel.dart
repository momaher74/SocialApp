import 'package:flutter/material.dart';

class CreateUser {
  String name, email, phone, uId, bio, profileImage, coverImage;
  bool isEmailVerified;

  CreateUser(
      {@required this.name,
      @required this.email,
      @required this.phone,
      @required this.uId,
      @required this.isEmailVerified,
      @required this.bio,
      @required this.profileImage,
      @required this.coverImage,
      });

  CreateUser.fromJson(json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    isEmailVerified = json['isEmailVerified'];
  }

  toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
    };
  }
}
