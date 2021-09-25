import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

class ChangeMobileNumberScreen extends StatelessWidget {
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your Phone Number',
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            SizedBox(height:10),
            Text(
              'We will send you a code to your new mobile number for verification',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 15),
            // CountryCodePicker(
            //   onChanged: print,
            //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            //   initialSelection: 'EG',
            //   favorite: ['+20','EG'],
            //   // optional. Shows only country name and flag
            //   showCountryOnly: false,
            //   // optional. Shows only country name and flag when popup is closed.
            //   showOnlyCountryWhenClosed: false,
            //   // optional. aligns the flag and the Text left
            //   alignLeft: false,
            //   builder:  (context) => defaultFormField(
            //       text: "Enter your phone number",
            //       keyboardType: TextInputType.phone
            //   ),
            // ),
            InternationalPhoneNumberInput(
              onInputChanged: (number){},

            ),
            Spacer(),
            Container(
              color: defaultColor,
              width: double.infinity,
              child: defaultTextButton(
                  color: Colors.white,
                  function: (){},
                  text: 'Update',
                  fontSize: 20
              ),
            )
          ],
        ),
      ),
    );
  }
}
