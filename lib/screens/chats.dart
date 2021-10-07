import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/screens/ChatDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).allUsers.length > 0,
          builder: (context) => ListView.builder(itemBuilder: (context, index) {
            return chatBuilder(
                context: context, model: AppCubit.get(context).allUsers[index]);
          },
           itemCount: AppCubit.get(context).allUsers.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  chatBuilder({@required context, @required model}) {
    return InkWell(
      onTap: () {
        navigatorTo(context, ChatDetailsScreen(model: model,));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple[800],
          borderRadius: BorderRadius.circular(35),
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                      model.profileImage ,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                model.name ,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
