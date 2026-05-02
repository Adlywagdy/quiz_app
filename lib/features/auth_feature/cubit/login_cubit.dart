import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginCubit() : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(credential.user!.uid));
    } on FirebaseAuthException catch (e) {
      emit(LoginFailureState(_getErrorMessage(e.code)));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(SignupLoadingState());
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignupSuccessState(credential.user!.uid));
    } on FirebaseAuthException catch (e) {
      emit(SignupFailureState(_getErrorMessage(e.code)));
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password should be at least 6 characters';
      case 'user-disabled':
        return 'This user has been disabled';
      default:
        return 'An error occurred. Please try again';
    }
  }
}