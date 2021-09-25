import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';

class RatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Account',
              style: TextStyle(
                  color: Color(0xff388E3C),
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              )
          )
      ),
      body: Column(
        children: [
          Text(
            'Please Rate your Experience:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            color: Color(0xff388E3C),
            child: defaultTextButton(
              color: Colors.white,
              backGroundColor: Color(0xff388E3C),
              function: () {
                // AppCubit.get(context).bookCourt();
              },
              text: 'Apply',
            ),
          ),

        ],
      ),
    );
  }
}
