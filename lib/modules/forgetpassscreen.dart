import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/modules/login/cubit/cubit.dart';
import 'package:yalla_hagz/modules/login/cubit/states.dart';
import 'package:yalla_hagz/shared/components.dart';

class ForgotPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, //Color(0xff38A3A5),
          elevation: 0,
          title: const Text(
            'Forgot Password',
            style: TextStyle(
                color: Color(0xff388E3C),
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
          ),
        ),
        body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            defaultFormField(
                controller: emailController,
                validate: (value){
                  if(value!.isEmpty) return ('Email shouldn\'t be empty');
                },
                text: 'Email Address',
                prefix: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress
            ),
            const SizedBox(height: 10,),
            Container(
              child: defaultTextButton(
                  function: (){
                    if (formKey.currentState!.validate()) {
                      cubit.forgetPasswordResetEmail(
                          email: emailController.text);
                    }
                    Navigator.pop(context);
                  },
                  text: 'Send Password Reset Email'),
            ),
          ],
        ),
        ),
      );

  }
}
