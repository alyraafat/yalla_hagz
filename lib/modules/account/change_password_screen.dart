import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

class ChangePasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Change Password'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            defaultFormField(
                text: 'Current Password',
                prefix: Icons.lock_outline_rounded,
                suffix: Icons.visibility_outlined
            ),
            SizedBox(height: 25,),
            defaultFormField(
                text: 'New Password',
                prefix: Icons.lock_outline_rounded,
                suffix: Icons.visibility_outlined
            ),
            SizedBox(height: 25,),
            defaultFormField(
                text: 'Confirm Password',
                prefix: Icons.lock_outline_rounded,
                suffix: Icons.visibility_outlined
            ),
            SizedBox(height: 25,),
            Text(
              'Try to make it a little bit difficult',
              style: TextStyle(
                  color: Colors.grey[500]
              ),
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
