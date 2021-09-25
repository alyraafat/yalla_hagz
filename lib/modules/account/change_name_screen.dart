import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';

class ChangeNameScreen extends StatelessWidget {

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
              'Update your name',
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            SizedBox(height:10),
            defaultFormField(
                prefix: Icons.people_outline,
                text: "Enter your full name"
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
