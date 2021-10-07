class AppStates {}

class AppInitialState extends AppStates {}

class ChangeIconState extends AppStates {}

class LoginLoadingState extends AppStates {}

class SignUpLoadingState extends AppStates {}

class LoginErrorState extends AppStates {}

class SignUpErrorState extends AppStates {}

class LoginSuccessState extends AppStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class SignUpSuccessState extends AppStates {}

class CreateUserSuccessState extends AppStates {
  final String uId;

  CreateUserSuccessState(this.uId);
}

class CreateUserLoadingState extends AppStates {}

class CreateUserErrorState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

class LogoutState extends AppStates {}

class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {}

class PickImageLoadingState extends AppStates {}

class PickProfileImageSuccessState extends AppStates {}

class PickCoverImageSuccessState extends AppStates {}

class PickProfileImageErrorState extends AppStates {}

class PickCoverImageErrorState extends AppStates {}

class UpdateCoverImageErrorState extends AppStates {}

class UpdateCoverImageSuccessState extends AppStates {}

class UpdateProfileImageSuccessState extends AppStates {}

class UpdateProfileImageErrorState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class UploadProfileImageLoadingState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadCoverImageLoadingState extends AppStates {}

class UpdateUserErrorState extends AppStates {}

class UpdateUserLoadingState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {}

class LikePostErrorState extends AppStates {}

class LikePostSuccessState extends AppStates {}

class GetLikePostSuccessState extends AppStates {}

class DeletePostImageSuccessState extends AppStates {}

class PickPostImageErrorState extends AppStates {}

class PickPostImageSuccessState extends AppStates {}

class GetPostLoadingState extends AppStates {}

class GetPostSuccessState extends AppStates {}

class GetPostErrorState extends AppStates {}

class CreateNoteLoadingState extends AppStates {}

class CreateNoteSuccessState extends AppStates {}

class CreateNoteErrorState extends AppStates {}

class GetNoteLoadingState extends AppStates {}

class GetNoteSuccessState extends AppStates {}

class GetNoteErrorState extends AppStates {}

class DeleteNoteLoadingState extends AppStates {}

class DeleteNoteSuccessState extends AppStates {}

class DeleteNoteErrorState extends AppStates {}

class GetAllUsersLoadingState extends AppStates {}

class GetAllUsersSuccessState extends AppStates {}

class GetAllUsersErrorState extends AppStates {}

class SendSuccessState extends AppStates {}

class SendImageMessageSuccessState extends AppStates {}

class RemoveChatImageSuccessState extends AppStates {}

class SendErrorState extends AppStates {}

class GetMessageSuccessState extends AppStates {}

class GetMessageErrorState extends AppStates {}
