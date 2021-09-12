abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final error;
  RegisterErrorState(this.error);
}

class ChangePasswordVisibilityStates extends RegisterStates {}
