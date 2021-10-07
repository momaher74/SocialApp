import 'package:flutter/cupertino.dart';

class NoteModel{
  String title , body ;
  NoteModel({
    @required this.title ,
    @required this.body ,
});
  NoteModel.fromJson(json){
    title = json['title'];
    body = json['body'];
  }
  toMap(){
    return
    {
     'title':title,
     'body':body ,
    };
  }
}