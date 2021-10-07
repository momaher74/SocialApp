import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/sharedpref.dart';
import 'package:firebaseabdallahmansour/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/blocobservation.dart';
import 'data/share component.dart';
import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp() ;
  // var   token =await FirebaseMessaging.instance.getToken();
  // print('tokeeeeeeeeeeeeeeen $token') ;
  await CacheHelper.init() ;
  uId = CacheHelper.getData(key: "uId") ;
  print(uId) ;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context)=>AppCubit()..getUser()..getPosts()..getNotes()..getAllUsers(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.deepPurple
              )
            ),
            home:uId == null ? LoginScreen() : HomeScreen(),
            debugShowCheckedModeBanner: false,
          ) ;
        },
      ),
    );
  }
}
