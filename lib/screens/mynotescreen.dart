import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var titleController = TextEditingController();

var bodyController = TextEditingController();

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreateNoteSuccessState) {
         //  AppCubit.get(context).notes = [];
           navigatorTo(context, HomeScreen());
           //AppCubit.get(context).getNotes();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('enter a note '),
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: "enter title",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                      )),
                ),
                SizedBox(
                  height: 22,
                ),
                TextFormField(
                  controller: bodyController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: "enter Note",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                      )),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            AppCubit.get(context).createNote(
                              title: titleController.text,
                              body: bodyController.text,
                            );

                          },
                          child: Text('Post Note')),
                    ),
                  ],
                ),
                if (state is CreateNoteLoadingState)
                  LinearProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
