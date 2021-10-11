
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/register/validate_email_address_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phone;
  RegisterScreen(this.phone);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state)
      {
        if (state is RegisterCreateUserSuccessState) {
          CacheHelper.saveData(
          key: 'uId',
          value: state.uid,
          ).then((value)
          {
              navigateTo(context,ValidateEmailAddressScreen());
          }
        );
        }
        if (state is RegisterCreateUserErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is RegisterErrorState) {
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
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40)
                      ),
                      Text(
                          'Register & Enjoy',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        context: context,
                        controller: nameController,
                        validate: (value){
                          if(value!.length < 3) return ('Username is too short');
                          if(value.length >= 20) return ('Username is too long');
                          if(value.isEmpty) return ('Username shouldn\'t be empty');
                          String one = "" ;
                          for(int i = 0; i<value.length;i++){
                            if(value[i] != " "){
                              one += value[i];
                            }
                          }
                          if(!isAlpha(one)) {
                            return ('Username should be composed of letters');
                          }
                        },
                        text: 'User Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        keyboardType: TextInputType.emailAddress,
                        context: context,
                        controller: emailController,
                        validate: (value){
                          if(value!.isEmpty) {
                            return ('Email shouldn\'t be empty');
                          }
                          if(!isEmail(value)) {
                            return ('Input should be an email');
                          }
                        },
                        text: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          context: context,
                          controller: passwordController,
                          validate: (value){
                            if(value!.isEmpty) {
                            return ('Password shouldn\'t be empty');
                          }
                          if(value.length<8) {
                              return ('Password must be more than 8 characters ');
                            }
                          },
                          isObscure: RegisterCubit.get(context).isPassword,
                          text: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixOnPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          }
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState||state is! AppGetAllUsersLoadingState,
                        builder: (context) =>
                            defaultButton(
                              onPressed: () {
                                bool phoneFound = false;
                                if (formKey.currentState!.validate())
                                  {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phone,
                                        context: context
                                    );
                                  }
                              },
                              text: 'register',
                              background: defaultColor,
                              isUpperCase: true,
                            ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator(
                              color: defaultColor,
                            )),
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