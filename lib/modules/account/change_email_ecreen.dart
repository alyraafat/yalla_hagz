import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

class ChangeEmailScreen extends StatelessWidget {

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
              'Update your email',
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            SizedBox(height:10),
            Text(
              'Recieve new info about new updates in your inbox',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 10),
            defaultFormField(
                prefix: Icons.email_outlined,
                text: "Enter your email address"
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
