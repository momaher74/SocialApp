import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/data/sharedpref.dart';
import 'package:firebaseabdallahmansour/homescreen.dart';
import 'package:firebaseabdallahmansour/models/createusermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  @override
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    var suffix = AppCubit.get(context).suffix;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
            navigatorAndReplacement(context, HomeScreen());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign up "),
          ),
          body: Form(
            key: formKey,
            child: Container(
              height: 800,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.deepPurple[800],
                  Colors.deepPurple[700],
                  Colors.deepPurple[600],
                  Colors.deepPurple[400],
                ],
              )),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sign up to buy all you need ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Not Valid";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "enter your name ",

                            //suffixIcon: Icon(Icons.email_outlined) ,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        controller: nameController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Not Valid";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.phone_android),
                            labelText: "enter your phone number ",
                            suffixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Not Valid";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: "enter your Email",
                            suffixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        controller: emailController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Not Valid";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: "enter your password",
                            suffixIcon: IconButton(
                              icon: Icon(AppCubit.get(context).suffix),
                              onPressed: () {
                                AppCubit.get(context).changeIcon();
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: AppCubit.get(context).isTrue,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! SignUpLoadingState,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurple),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      AppCubit.get(context).signUp(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text);
                                    }
                                  },
                                  child: Text("Sign up")),
                            );
                          },
                          fallback: (context) {
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
