import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var profileImage = AppCubit
        .get(context)
        .profileImage;
    var coverImage = AppCubit
        .get(context)
        .coverImage;
    var model = AppCubit
        .get(context)
        .userModel;
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    emailController.text = model.email.toString();
    phoneController.text = model.phone.toString();
    bioController.text = model.bio.toString();
    nameController.text = model.name.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (state is UpdateUserLoadingState)
                  SizedBox(
                    height: 15,
                  ),
                if (state is UpdateUserLoadingState) LinearProgressIndicator(),
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
                                image: AppCubit
                                    .get(context)
                                    .coverImage != null
                                    ? FileImage(coverImage)
                                    : NetworkImage(
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
                                    AppCubit.get(context).pickCoverImage();
                                  }),
                            )),
                      ],
                    ),
                    Stack(
                      //profile stack
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 48,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                  AppCubit
                                      .get(context)
                                      .profileImage != null
                                      ? FileImage(profileImage)
                                      : NetworkImage(
                                      model.profileImage.toString()),
                                )),
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
                                    AppCubit.get(context).pickProfileImage();
                                  })),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model.name.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                if (coverImage != null || profileImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      if (profileImage != null)
                      Expanded(
                          child: Column(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  AppCubit.get(context).uploadProfileImage();
                                },
                                child: Text("upload profile"),
                              ),
                              if (state is UploadProfileImageLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      if (coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                AppCubit.get(context).uploadCoverImage() ;
                              },
                              child: Text("upload cover"),
                            ),
                            if (state is UploadCoverImageLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                          labelText: "name",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                          labelText: " phone ",
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                          labelText: " email ",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: bioController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.deepPurple,
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                          labelText: " bio ",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 12,),
                      if(state is UpdateUserLoadingState)
                        LinearProgressIndicator() ,
                      if(state is!UpdateUserLoadingState)
                      Container(
                        margin: EdgeInsets.all(15),
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            AppCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text,
                              email: emailController.text,
                            );
                          },
                          child: Text("update"),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
