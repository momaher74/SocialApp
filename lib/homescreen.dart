import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/icon_broken.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/screens/notifacation.dart';
import 'package:firebaseabdallahmansour/screens/posts.dart';
import 'package:firebaseabdallahmansour/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppCubit.get(context)
                .titles[AppCubit.get(context).currentIndex]),
            actions: [
              IconButton(
                  icon: Icon(IconBroken.Notification),
                  onPressed: () {
                    navigatorTo(context, NotificationScreen());
                  }),
              Padding(
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child: IconButton(
                      icon: Icon(IconBroken.Search),
                      onPressed: () {
                        navigatorTo(context, SearchScreen());
                      })),
            ],
          ),
          body:
              AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex:AppCubit.get(context).currentIndex ,
          //   onTap: (index){
          //     AppCubit.get(context).changeBottomNav(index);
          //   },
          //   items: [
          //     BottomNavigationBarItem(icon: Icon(IconBroken.Home) , label: "Home" ) ,
          //     BottomNavigationBarItem(icon: Icon(IconBroken.Chat) , label: "Chat" ) ,
          //  //  BottomNavigationBarItem(icon: Icon(Icons.person) , label: "Home" ) ,
          //     BottomNavigationBarItem(icon: Icon(IconBroken.Setting) , label: "Setting" ) ,
          //   ],
          // ),
          bottomNavigationBar: CurvedNavigationBar(
            index: AppCubit.get(context).currentIndex,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            items: <Widget>[
              Icon(
                IconBroken.Home,
                size: 30,
              ),
              Icon(IconBroken.Chat, size: 30),
              Icon(IconBroken.Setting, size: 30),
              Icon(IconBroken.Bookmark, size: 30),
            ],
            onTap: (index) {
              AppCubit.get(context).changeBottomNav(index);
              //Handle button tap
            },
          ),
          // bottomNavigationBar: ConvexAppBar(
          // activeColor: Colors.deepPurple,
          //   backgroundColor: Colors.white,
          //   color: Colors.blue,
          //   items: [
          //     TabItem(icon: IconBroken.Home, title: 'Home'),
          //     TabItem(icon: IconBroken.Chat, title: 'Chat'),
          //     TabItem(icon: IconBroken.Setting, title: 'Setting'),
          //   ],
          //   initialActiveIndex: AppCubit.get(context).currentIndex,//optional, default as 0
          //   onTap: (index){
          //     AppCubit.get(context).changeBottomNav(index) ;
          //   },
          // ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              navigatorTo(context, PostScreen());
            },
            child: Icon(
              Icons.post_add,
              color: Colors.cyan,
            ),
          ),
          // drawer: Drawer(
          //   child: Container(
          //     color: Colors.grey,
          //     child: Padding(
          //       padding: EdgeInsets.all(20),
          //       child: Column(
          //         children: [
          //           SizedBox(height: 30,) ,
          //           Container(
          //             width: double.infinity,
          //             height: 50,
          //             child: ElevatedButton(
          //               onPressed: () {
          //
          //               },
          //               child: Text("Logout"),
          //               style: ButtonStyle(
          //                   backgroundColor:
          //                   MaterialStateProperty.all(Colors.deepPurple)),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
