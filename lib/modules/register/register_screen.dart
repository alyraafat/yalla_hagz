
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/register/validateemailaddress.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state)
      {
        if (state is RegisterCreateUserSuccessState) {
          // CacheHelper.saveData(
          // key: 'uId',
          // value: state.uid,
          // ).then((value)
          // {
            navigateAndFinish(
              context,
              ValidateEmailAddress(),
            );
          // }
        //);
        }
        if (state is RegisterCreateUserErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black, fontSize: 40)
                      ),
                      Text(
                          'Register & Enjoy',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        validate: (value){
                          if(value!.isEmpty) return ('Username shouldn\'t be empty');
                        },
                        text: 'User Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        validate: (value){
                          if(value!.isEmpty) return ('Email shouldn\'t be empty');
                        },
                        text: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          validate: (value){
                            if(value!.isEmpty) return ('Password shouldn\'t be empty');
                          },
                          isObscure: RegisterCubit.get(context).isPassword,
                          text: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixOnPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          }
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        validate: (value){
                          if(value!.isEmpty) return ('Phone shouldn\'t be empty');
                        },
                        text: 'Phone',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) =>
                            defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate())
                                {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    context:context
                                  );
                                }
                              },
                              text: 'register',
                              background: defaultColor,
                              isUpperCase: true,
                            ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}