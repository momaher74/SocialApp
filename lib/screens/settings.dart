import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/data/icon_broken.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/models/postmodel.dart';
import 'package:firebaseabdallahmansour/screens/posts.dart';
import 'package:firebaseabdallahmansour/screens/users.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = AppCubit.get(context).userModel;
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      //coverImage
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 200,
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              model.coverImage.toString(),
                            ))),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                navigatorTo(context, UsersScreen());
                              }),
                        )),
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 48,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          model.profileImage.toString(),
                        ),
                        radius: 45,
                      ),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(0),
                          child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: 14,
                              ),
                              onPressed: () {
                                navigatorTo(context, UsersScreen());
                              })),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Text(
                    model.name.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                      model.bio.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Posts",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                               AppCubit.get(context).posts.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Photos",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Follower",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Following",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                navigatorTo(context, PostScreen()) ;
                              },
                              child: Text(
                                "Add photos",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue),
                              ))),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigatorTo(context, UsersScreen());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          color: Colors.blue,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                      ),
                    ],
                  ),
                ) ,
                ConditionalBuilder(
                  condition: AppCubit.get(context).posts.length > 0,
                  builder: (context) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => postBuilder(
                        context: context,
                        model: AppCubit.get(context).posts[index]),
                    itemCount: AppCubit.get(context).posts.length,
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ) ,
              ],
            )
          ],
        ),
      )),
    );
  }
  postBuilder({@required context, @required PostModel model}) {
    return Card(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.red,
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    navigatorTo(context, SettingScreen());
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      model.profileImage.toString(),
                    ),
                    radius: 25,
                  ),
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
                        model.name.toString(),
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
                  Text(
                    model.dateTime.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.more_horiz_outlined), onPressed: () {}),
            ],
          ),

          Padding(
              padding: EdgeInsets.all(10), child: Text(model.text.toString() , style: TextStyle(fontSize: 18),)),
          if (model.postImage != null)
            Padding(
              padding: EdgeInsets.all(10),
              child: InteractiveViewer(
                alignPanAxis: true,
                maxScale: 2,
                child: Image(
                  // fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                    image: NetworkImage(model.postImage.toString())),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("20 Like "),
                Text("0 Comment"),
                Text("0 Share "),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.favorite_border_sharp,
                            ),
                            onPressed: () {}),
                        Text("Like")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                IconBroken.Chat,
                              ),
                              onPressed: () {}),
                          Text("Comment")
                        ],
                      )),
                ),
                Expanded(
                  child: InkWell(
                      child: Row(
                        children: [
                          IconButton(icon: Icon(IconBroken.Send), onPressed: () {}),
                          Text("Share")
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
