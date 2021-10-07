import 'package:flutter/material.dart';

class PostModel {
  String name, postImage, text, uId, profileImage;
  var dateTime ;

  PostModel({
    @required this.name,
    @required this.postImage,
    @required this.text,
    @required this.uId,
    @required this.dateTime,
    @required this.profileImage,
  });

  PostModel.fromJson(json) {
    name = json['name'];
    postImage = json['postImage'];
    text = json['text'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    profileImage = json['profileImage'];
  }

  toMap() {
    return {
      'postImage': postImage,
      'name': name,
      'text': text,
      'uId': uId,
      'dateTime': dateTime,
      'profileImage': profileImage,
    };
  }
}
