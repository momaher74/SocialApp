import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mynotescreen.dart';

class AddNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: AppCubit.get(context).notes.length > 0,
                    builder: (context) => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return noteBuilder(
                          context,
                          index,
                        );
                      },
                      itemCount: AppCubit.get(context).notes.length,
                    ),
                    fallback: (context) => Center(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.deepPurple,
                      ),
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline , color: Colors.white,) ,
                            SizedBox(width: 20,),
                            Text(
                              "No Notes here ",
                              style: TextStyle(color: Colors.white, fontSize: 23),
                            )
                          ],
                        ),
                      ),
                    )),
                  ),
                  //   Text(AppCubit.get(context).notes[0].title.toString()) ,

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          navigatorTo(context, NotesScreen());
                        },
                        child: Text('Add Note'),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  noteBuilder(context, int index) {
    var cubit = AppCubit.get(context);
    var model = cubit.notes[index];
    var elementId = cubit.elementId[index];
    return Dismissible(
      key: Key(elementId.toString()),
      onDismissed: (direction){
        AppCubit.get(context).deleteNote(elementId);
        //AppCubit.get(context).notes = [] ;
      //   AppCubit.get(context).getNotes() ;

      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12 , vertical:  8 ),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                color: Colors.deepPurple,
                child: Column(
                  children: [
                    Text(
                      model.title.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      height: 2,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.body.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  AppCubit.get(context).deleteNote(elementId);
                  // AppCubit.get(context).notes = [] ;
                  // AppCubit.get(context).getNotes() ;
                },
                child: Text('delete'),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.deepPurple,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
