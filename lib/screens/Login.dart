import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebaseabdallahmansour/cubit/cubit.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/data/sharedpref.dart';
import 'package:firebaseabdallahmansour/homescreen.dart';
import 'package:firebaseabdallahmansour/screens/Sign%20up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    //var suffix = AppCubit.get(context).suffix ;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
         CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
         }) ;
        }
        if (state is LoginErrorState) {
          flutterToast("maybe email or password is false", Colors.red);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text("Login "),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600,
            width: double.infinity,
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "login to buy all you need ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Data Not Valid";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          labelText: "enter your Email ",
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      controller: emailController,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Data Not Valid";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: "enter your password ",
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              AppCubit.get(context).suffix,
                              color: Colors.white,
                            ),
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
                      height: 55,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      builder: (context) => Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.deepPurple),
                              ),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  AppCubit.get(context).login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text("Login"))),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                            },
                            child: Text(
                              "Register now",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
