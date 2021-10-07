import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


navigatorAndReplacement(context ,Widget screen ){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>screen));
}
navigatorTo(context , screen){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>screen));
}
flutterToast(String text , Color color) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
// ignore: non_constant_identifier_names
String IMG = 'https://img.freepik.com/free-photo/portrait-charismatic-beaded-guy-white-sweater-assure-you-winking-showing-okay-sign-guar_1258-64213.jpg?size=626&ext=jpg' ;
// leading: Row(
// children: [
// IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
// Navigator.pop(context) ;
// }) ,

// ],

// ),

TextStyle myStyle =  TextStyle(
  fontSize: 20,
  color: Colors.white ,
) ;

SizedBox  width = SizedBox(width: 20,) ;
SizedBox  height = SizedBox(width: 20,) ;
String uId = '';