import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/register/phone_authentication_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

class ValidateEmailAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Please verify your email Address',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultTextButton(
                      function: (){
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        showToast(
                            text: "Check your junk or spam or inbox for the verification email",
                            state:ToastStates.WARNING
                        );
                      },
                      text: 'Send Verification Email'
                  ),
                  defaultTextButton(
                    function: () async{
                      await FirebaseAuth.instance.currentUser!.reload();
                      if (FirebaseAuth.instance.currentUser!.emailVerified){
                        navigateAndReplace(context, BottomNavScreen());
                        AppCubit.get(context).updateUserData(data: {
                          "isEmailVerified":true,
                          "isPhoneVerified":true
                        });
                        //update the user
                      }
                      else{
                        showToast(
                            text: 'Please verify your email to continue',
                            state: ToastStates.WARNING
                        );
                      }
                    },
                    text: 'Continue'
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
