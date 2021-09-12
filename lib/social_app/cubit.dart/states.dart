abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUsererrorState extends SocialStates {
  final String error;
  SocialGetUsererrorState(this.error);
}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostserrorState extends SocialStates {
  final String error;
  SocialGetPostserrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePosterrorState extends SocialStates {
  final String error;
  SocialLikePosterrorState(this.error);
}

class SocialNewPostState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageErrorState extends SocialStates {}

class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialStates {}

class SocialUploadImageSuccessState extends SocialStates {}

class SocialUploadImageErrorState extends SocialStates {}

class SocialUserUpdateImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingImageState extends SocialStates {}

class ChangeIsClickFormFieldState extends SocialStates {}

class PickProfileImageLoadingState extends SocialStates {}

class PickProfileImageSuccessState extends SocialStates {}

class PickProfileImageErrorState extends SocialStates {}

class PickCoverImageLoadingState extends SocialStates {}

class PickCoverImageSuccessState extends SocialStates {}

class PickCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateSuccessState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImageSuccessState extends SocialStates {}

class SocialPostImageErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}
