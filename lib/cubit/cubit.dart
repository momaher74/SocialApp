import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseabdallahmansour/cubit/states.dart';
import 'package:firebaseabdallahmansour/data/share%20component.dart';
import 'package:firebaseabdallahmansour/models/createusermodel.dart';
import 'package:firebaseabdallahmansour/models/message.dart';
import 'package:firebaseabdallahmansour/models/noteModel.dart';
import 'package:firebaseabdallahmansour/models/postmodel.dart';
import 'package:firebaseabdallahmansour/screens/chats.dart';
import 'package:firebaseabdallahmansour/screens/feeds.dart';
import 'package:firebaseabdallahmansour/screens/notes.dart';
import 'package:firebaseabdallahmansour/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // variables

  bool isTrue = true;

  int currentIndex = 0;

  IconData suffix = Icons.visibility;

  CreateUser userModel;

  PostModel postModel;

  NoteModel noteModel;

  List<PostModel> posts = [];

  List postId = [];

  List postLike = [];

  File profileImage;

  File coverImage;

  File postPickedImage;

  File chatImage;

  ImagePicker picker = ImagePicker();

  //functions

  getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = CreateUser.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState());
    });
  }

  Future<void> pickProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      emit(PickProfileImageSuccessState());
    } else {
      print('No  Profile image selected.');
      emit(PickProfileImageErrorState());
    }
  }

  Future<void> pickChatImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(PickPostImageSuccessState());
    } else {
      print('No Cover image selected.');
      emit(PickPostImageErrorState());
    }
  }

  Future<void> pickCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickCoverImageSuccessState());
    } else {
      print('No Cover image selected.');
      emit(PickCoverImageErrorState());
    }
  }

  Future<void> pickPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postPickedImage = File(pickedFile.path);
      emit(PickPostImageSuccessState());
    } else {
      print('No Cover image selected.');
      emit(PickPostImageErrorState());
    }
  }

  changeIcon() {
    isTrue = !isTrue;
    suffix = isTrue ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ChangeIconState());
  }

  login({
    @required email,
    @required password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  signUp({
    @required email,
    @required password,
    @required name,
    @required phone,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        email: email,
        uId: value.user.uid,
        name: name,
        phone: phone,
      );
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState());
    });
  }

  createUser({
    @required email,
    @required uId,
    @required name,
    @required phone,
  }) {
    userModel = CreateUser(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      bio: 'write yor bio ...',
      profileImage: IMG,
      coverImage: IMG,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      print("enter to success");
      emit(CreateUserSuccessState(uId));
    }).catchError((error) {
      print("$error");
      emit(CreateUserErrorState());
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    SettingScreen(),
    AddNoteScreen(),
  ];

  List titles = ["Feeds", "Chats", "Settings", 'Notes'];

  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  signOut({
    @required context,
    @required screen,
  }) {
    FirebaseAuth.instance.signOut().then((value) {
      navigatorAndReplacement(context, screen);
      emit(LogoutState());
    });
  }

  String profileUrl;

  void uploadProfileImage() {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel = CreateUser(
          name: userModel.name,
          email: userModel.email,
          phone: userModel.phone,
          uId: userModel.uId,
          isEmailVerified: userModel.isEmailVerified,
          bio: userModel.bio,
          profileImage: value,
          coverImage: userModel.coverImage,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .update(userModel.toMap())
            .then((value) {
          getUser();
          emit(UpdateProfileImageSuccessState());
        });
      });
    });
  }

  void uploadCoverImage() {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel = CreateUser(
          name: userModel.name,
          email: userModel.email,
          phone: userModel.phone,
          uId: userModel.uId,
          isEmailVerified: userModel.isEmailVerified,
          bio: userModel.bio,
          profileImage: userModel.profileImage,
          coverImage: value,
        );
        FirebaseFirestore.instance
            .collection("users")
            .doc(uId)
            .update(userModel.toMap())
            .then((value) {});
        emit(UploadCoverImageSuccessState());
        getUser();
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
    @required String bio,
    String profile,
    String cover,
  }) {
    emit(UpdateUserLoadingState());
    userModel = CreateUser(
      name: name,
      phone: phone,
      email: email,
      isEmailVerified: userModel.isEmailVerified,
      uId: uId,
      bio: bio,
      profileImage: profile ?? userModel.profileImage,
      coverImage: cover ?? userModel.coverImage,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      print('update success bro ');
      getUser();
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  void createPost({
    String text,
    var dateTime,
  }) {
    emit(CreatePostLoadingState());
    if (postPickedImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child("posts${Uri.file(postPickedImage.path).pathSegments.last}")
          .putFile(postPickedImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          postModel = PostModel(
            name: userModel.name,
            postImage: value,
            text: text,
            uId: uId,
            dateTime: dateTime,
            profileImage: userModel.profileImage,
          );
          FirebaseFirestore.instance
              .collection('posts')
              .add(postModel.toMap())
              .then((value) {
            emit(CreatePostSuccessState());
          }).catchError((error) {
            emit(CreatePostErrorState());
          });
        });
      });
    } else {
      postModel = PostModel(
        name: userModel.name,
        postImage: null,
        text: text,
        uId: uId,
        dateTime: dateTime,
        profileImage: userModel.profileImage,
      );
      FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap())
          .then((value) {
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }
  }

  void getPosts() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          print('post is ${posts[0]}');
          postLike.add(value.docs.length);
          emit(GetLikePostSuccessState());
        }).catchError((error) {});
      });
      //print(value.data());
      emit(GetPostSuccessState());
    }).catchError((error) {
      emit(GetPostErrorState());
    });
  }

  void deletePostImage() {
    postPickedImage = null;
    emit(DeletePostImageSuccessState());
  }

  void likePost(postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'postLike': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  createNote({
    @required title,
    @required body,
  }) {
    emit(CreateNoteLoadingState());
    noteModel = NoteModel(title: title, body: body);
    FirebaseFirestore.instance
        .collection('notes')
        .add(noteModel.toMap())
        .then((value) {
      emit(CreateNoteSuccessState());
      notes = [];
      getNotes();
    }).catchError((error) {
      emit(CreateNoteErrorState());
    });
  }

  List notes = [];

  List elementId = [];

  getNotes() {
    emit(GetNoteLoadingState());
    FirebaseFirestore.instance.collection('notes').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        elementId.add(element.id);
        notes.add(NoteModel.fromJson(element.data()));
        //   print(' id lissssssssssssssssst is  ${elementId}');
        emit(GetNoteSuccessState());
      });
    }).catchError((error) {
      print('err is $error');
      emit(GetNoteErrorState());
    });
  }

  deleteNote(docId) {
    FirebaseFirestore.instance
        .collection('notes')
        .doc(docId)
        .delete()
        .then((value) {
      emit(DeleteNoteSuccessState());
      notes = [];
      getNotes();
    }).catchError((error) {
      emit(DeleteNoteErrorState());
    });
  }

  List allUsers = [];
  List allUsersId = [];

  getAllUsers() {
    if (allUsers.length == 0) {
      emit(GetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.id != userModel.uId) {
            allUsers.add(CreateUser.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState());
      });
    }
  }

   sendMessage({
    @required String text,
    @required String receiverId,
    @required var dateTime,
  }) {
    if (chatImage == null) {
      MessageModel model =
          MessageModel(text, userModel.uId, receiverId, dateTime, null);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendSuccessState());
      }).catchError((error) {
        emit(SendErrorState());
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(userModel.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendSuccessState());
      }).catchError((error) {
        emit(SendErrorState());
      });
    } else {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images ${Uri.file(chatImage.path).pathSegments.last}')
          .putFile(chatImage)
          .then((value) {
            value.ref.getDownloadURL().then((value) {
              MessageModel model =
              MessageModel(text, userModel.uId, receiverId, dateTime , value);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userModel.uId)
                  .collection('chats')
                  .doc(receiverId)
                  .collection('messages')
                  .add(model.toMap())
                  .then((value) {
                emit(SendImageMessageSuccessState());
              }).catchError((error) {
                emit(SendErrorState());
              });
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(receiverId)
                  .collection('chats')
                  .doc(userModel.uId)
                  .collection('messages')
                  .add(model.toMap())
                  .then((value) {
                emit(SendImageMessageSuccessState());
              }).catchError((error) {
                emit(SendErrorState());
              });
            }).then((value){
              removeChatImage() ;
            } ) ;
      })
          .catchError((error) {}
      );
    }
  }

  List<MessageModel> messages = [];

  getMessages({
    String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessageSuccessState());
    });
  }
  removeChatImage(){
    chatImage = null ;
    emit(RemoveChatImageSuccessState()) ;
  }
}
