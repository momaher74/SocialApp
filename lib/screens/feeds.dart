import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/icon_broken.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/models/postmodel.dart';
import 'package:firebaseabdallahmansour/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderOnForeground: true,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://image.freepik.com/free-photo/mand-holding-cup_1258-340.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 35,
                    color: Colors.black.withOpacity(.6),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "communicate with friends ",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
              ConditionalBuilder(
                condition: AppCubit
                    .get(context)
                    .posts
                    .length > 0,
                builder: (context) =>
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          postBuilder(
                              context: context,
                              model: AppCubit
                                  .get(context)
                                  .posts[index],
                              index: index
                          ),
                      itemCount: AppCubit
                          .get(context)
                          .posts
                          .length,
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        );
      },
    );
  }

  postBuilder({@required context, @required PostModel model,@required int index}) {
    var cubit = AppCubit.get(context);
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
                padding: EdgeInsets.symmetric(horizontal: 10 ,vertical:  8),
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
          if (model.text != null)
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  model.text.toString(),
                  style: TextStyle(fontSize: 18),
                )),
          if (model.postImage != null)
            Padding(
              padding: EdgeInsets.all(4),
              child: InteractiveViewer(
                alignPanAxis: true,
                maxScale: 2,
                child: Image(
                  // fit: BoxFit.cover,
                    width: double.infinity,
                    image: NetworkImage(model.postImage.toString())),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cubit.postLike[index].toString()),
                Text("0 Comment"),
                // Text("0 Share "),
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
                          onPressed: () {
                            cubit.likePost(cubit.postId[index]) ;
                          },),
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
                              onPressed: () {

                              }),
                          Text("Comment")
                        ],
                      )),
                ),
                // Expanded(
                //   child: InkWell(
                //       child: Row(
                //     children: [
                //       IconButton(
                //         icon: Icon(IconBroken.Send),
                //         onPressed: () {},
                //       ),
                //       Text("Share")
                //     ],
                //   )),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
