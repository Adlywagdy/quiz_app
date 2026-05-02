abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uid;
  LoginSuccessState(this.uid);
}

class LoginFailureState extends LoginStates {
  final String errorMessage;
  LoginFailureState(this.errorMessage);
}

class SignupLoadingState extends LoginStates {}

class SignupSuccessState extends LoginStates {
  final String uid;
  SignupSuccessState(this.uid);
}

class SignupFailureState extends LoginStates {
  final String errorMessage;
  SignupFailureState(this.errorMessage);
}