import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/register/cubit/cubit.dart';
import 'package:yalla_hagz/modules/register/register_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneAuthenticationScreen extends StatefulWidget {
  @override
  _PhoneAuthenticationScreenState createState() => _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential?.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen(phoneController.text)));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      showToast(
          text:e.message!,
          state:ToastStates.ERROR
      );
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        defaultFormField(
          prefix: Icons.phone_android_outlined,
          controller: phoneController,
          text: 'Phone Number',
        ),
        const SizedBox(
          height: 16,
        ),
        defaultTextButton(
          function: () async {
            bool phoneFound = false;
            for(int i=0;i<RegisterCubit.get(context).usersPhones.length;i++)
            {
              if(RegisterCubit.get(context).usersPhones[i]==phoneController.text){
                showToast(
                  text: "This phone number has been used by another account",
                  state: ToastStates.ERROR,
                );
                phoneFound = true;
                break;
              }
            };
            if(!phoneFound){
              setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: "+2${phoneController.text}",
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                  //signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  showToast(
                      text: verificationFailed.message!,
                      state: ToastStates.ERROR);
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            }
          },
          color: defaultColor,
          text: 'SEND',
        ),
        const Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        defaultFormField(
          prefix: Icons.verified_user_outlined,
          controller: otpController,
          text:"Enter OTP"
        ),
        SizedBox(
          height: 16,
        ),
        defaultTextButton(
          function: () async {
            PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          color: defaultColor,
          text: 'VERIFY',
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    RegisterCubit.get(context).getAllUsers();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: Container(
          child: showLoading ? Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}