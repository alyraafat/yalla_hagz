import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/modules/login/cubit/states.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  void forgetPasswordResetEmail ({
    required String email

  }) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email)
        .then((value) {
          showToast(text: 'Reset Email has been sent, Please check your inbox and spam', state: ToastStates.SUCCESS);
        }).catchError((error) {
      showToast(text: 'An error has occurred, Please try again', state: ToastStates.ERROR);
    })
    ;
  }
  void changePassword ({
    required String newPassword,
}){
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword)
      .then((value) {
        showToast(text: 'Password has been changed Successfully', state: ToastStates.SUCCESS);
      }).catchError((error){
       showToast(text: 'An error has occurred, Please try again ', state: ToastStates.WARNING);
      });
  }
  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          uId = value.user!.uid;
      AppCubit.get(context).getUserData();
      emit(LoginSuccessState(value.user!.uid));
    })
        .catchError((error)
    {
      emit(LoginErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined ;

    emit(ChangePasswordVisibilityState());
  }
}