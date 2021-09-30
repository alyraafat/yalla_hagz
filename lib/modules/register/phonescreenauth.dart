import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

class PhoneScreenAuthentication extends StatelessWidget {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, //Color(0xff38A3A5),
          elevation: 0,
          title: const Text(
            'Phone Verification',
            style: TextStyle(
                color: Color(0xff388E3C),
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please enter the  code',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: 5,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    inactiveFillColor: defaultColor,
                    inactiveColor: defaultColor,
                    selectedColor: defaultColor,
                    selectedFillColor: Colors.white,
                    activeFillColor: Colors.white,
                    disabledColor: Colors.white,
                    activeColor: Colors.green,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    // print(value);
                    // setState(() {
                    //   currentText = value;
                    // });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");

                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(height: 50,),
                Container(
                    width: double.infinity,
                    color: defaultColor,
                    child: defaultTextButton(
                      function: (){},
                      text: 'Verify',
                      color: Colors.white,
                    )
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children:  [
                      const Text(
                        'Message didnot reach you',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      defaultTextButton(
                          function: (){
                          },
                          text: 'Resend',
                          fontSize: 14,
                          color: defaultColor
                      )
                    ]
                ),

              ],
            ),
          ),
        ));
  }
}
