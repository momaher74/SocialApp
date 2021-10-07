import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/models/createusermodel.dart';
import 'package:firebaseabdallahmansour/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  CreateUser model;

  ChatDetailsScreen({@required this.model});

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    DateTime now = DateTime.now();
    var cubit = AppCubit.get(context);
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getMessages(receiverId: model.uId);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          model.profileImage,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: ConditionalBuilder(
                condition: state is GetMessageSuccessState ||
                    cubit.messages.length>0,
                builder: (context) {
                  return
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var messages = AppCubit.get(context).messages[index];
                              if (AppCubit.get(context).userModel.uId == messages.senderId) {
                                return buildMyMessage(messages);
                              } else
                                return buildMessage(messages);
                            },
                            itemCount: AppCubit.get(context).messages.length,
                          ),
                          if (cubit.chatImage != null)
                           Container(
                             decoration: BoxDecoration(
                               color: Colors.deepPurple,
                               borderRadius: BorderRadius.circular(22) ,
                             ),
                            margin: EdgeInsets.symmetric(horizontal: 20),

                             child:Image(
                               width: 400,
                               height: 300,
                               image: FileImage(cubit.chatImage),
                             ),
                           ),
                          if (AppCubit.get(context).messages.length == 0)
                            SizedBox(
                              height: 500,
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        labelText: 'Write your message  here ...'),
                                  ),
                                ),
                                width,
                                Container(
                                  height: 50,
                                  child: IconButton(
                                    icon: Icon(Icons.image),
                                    onPressed: () {
                                      cubit.pickChatImage();
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(shape: BoxShape.circle),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.grey[200]),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      onPressed: () {
                                        AppCubit.get(context).sendMessage(
                                          text: messageController.text,
                                          receiverId: model.uId,
                                          dateTime: now,
                                        );
                                        },
                                      child: Icon(
                                        Icons.send,
                                        size: 30,
                                        color: Colors.deepPurple,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ;
                },
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  //  detailChatBuilder({
  //   @required context,
  // }) {
  //
  //   return null ;
  // }

  buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          padding: EdgeInsets.all(10),
          //color: Colors.grey,
          child: Column(
            children: [
              if (message.image != null)
                Image(image: NetworkImage('${message.image}')),
              SizedBox(
                height: 5,
              ),
              if (message.text != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "${message.text}",
                    style: myStyle,
                  ),
                ),
            ],
          ),
        ),
      );

  buildMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          padding: EdgeInsets.all(10),
          //color: Colors.grey,
          child: Column(
            children: [
              if (message.image != null)
                Image(image: NetworkImage('${message.image}')),
              SizedBox(
                height: 5,
              ),
              if (message.text != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "${message.text}",
                    style: myStyle,
                  ),
                ),
            ],
          ),
        ),
      );
}
