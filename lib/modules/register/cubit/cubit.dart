import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/models/user_model.dart';
import 'package:yalla_hagz/modules/register/cubit/states.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) {
    print('hello');

    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        phone: phone,
        email: email,
        name: name,
        userId: value.user!.uid,
        context: context
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String userId,
    required BuildContext context,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      tournamentIds: [],
      balance: 0,
      points: 0,
      userId: userId,
      friendIds: [],
      mala3eb: [],
      teamNames: [],

    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(model.toMap())
        .then((value)
    {
      uId = model.userId;
      AppCubit.get(context).getUserData();
      emit(RegisterCreateUserSuccessState(model.userId));
    })
        .catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}

