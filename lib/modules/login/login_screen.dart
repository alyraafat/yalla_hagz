
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/first_screen.dart';
import 'package:yalla_hagz/modules/register/register_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if(state is LoginSuccessState)
        {
          CacheHelper.saveData(
            key: 'uId',
            value: state.uid,
          ).then((value)
          {
            navigateAndFinish(
              context,
              FirstScreen(),
            );
          }
          );
        }
      },

      builder: (context, state) {
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black, fontSize: 40)
                      ),
                      Text(
                          'Reserve & Enjoy',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        validate: (value){
                          if(value!.isEmpty) return ('Email shouldn\'t be empty');
                        },
                        text: 'Email Address',
                        prefix: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          validate: (value){
                            if(value!.isEmpty) return ('Password shouldn\'t be empty');
                          },
                          isObscure: LoginCubit.get(context).isPassword,
                          text: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: LoginCubit.get(context).suffix,
                          suffixOnPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          }
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                            text: 'login',
                            background: defaultColor,
                            isUpperCase: true,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context
                                );
                              }
                            }
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () {  },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'or continue with:',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(

                        child: SignInButton(
                          Buttons.FacebookNew,
                          text: "Sign in with Facebook",
                          onPressed: () {},
                        ),
                        width: double.infinity,
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: SignInButton(
                          Buttons.Google,
                          text: "Sign in with Google",
                          onPressed: () {},
                        ),
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            text: 'REGISTER',
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}