import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/homescreen.dart';
import 'package:firebaseabdallahmansour/models/createusermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is CreatePostSuccessState) {
            AppCubit.get(context).posts = [] ;
            navigatorTo(context, HomeScreen()) ;
            AppCubit.get(context).postPickedImage = null ;
            AppCubit.get(context).getPosts() ;
          }

        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
         // PostModel postModel = AppCubit.get(context).postModel;
          CreateUser userModel = AppCubit.get(context).userModel;
          return SingleChildScrollView(
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  SizedBox(height: 10,),
                if (state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userModel.profileImage.toString(),
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              userModel.name.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.verified_rounded,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Text(formattedDate.toString(), style: TextStyle(color: Colors.grey), ) ,

                      ],
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.more_horiz_outlined),
                        onPressed: () {}),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      labelText: "Write your post ",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      AppCubit.get(context).pickPostImage() ;
                    },
                    child: Text("Add Photo"),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple)),
                  ),
                ),
                if (cubit.postPickedImage != null)
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image(
                            height:300,
                            image:FileImage(cubit.postPickedImage)),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: MaterialButton(
                            minWidth: 1.0,
                            height: 20,
                            onPressed: () {
                              cubit.deletePostImage() ;
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                Container(
                  margin: EdgeInsets.all(15),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.createPost(
                        text: textController.text,
                        dateTime: formattedDate,
                      );
                    },
                    child: Text("Post"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
