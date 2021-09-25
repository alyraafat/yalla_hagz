import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

import 'rating_screen.dart';


class PaymentScreen extends StatelessWidget {
  @override
  var choose;
  PaymentScreen(this.choose);

  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(
              color: Color(0xff388E3C),
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Credit',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(width:5),
                Text(
                  'EGP',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text(
              'Pay With',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.circle_outlined),
                  SizedBox(width: 5,),
                  Icon(Icons.credit_card),
                  SizedBox(width: 5),
                  Text('Credit/Debit Card'),
                ],
              ),

            ),
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.circle_outlined),
                  SizedBox(width: 5,),
                  Icon(Icons.money),
                  SizedBox(width: 5),
                  Text('Cash'),
                ],
              ),

            ),
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.circle_outlined),
                  SizedBox(width: 5,),
                  Icon(Icons.money),
                  SizedBox(width: 5),
                  Text('Vodafone Cash'),
                ],
              ),

            ),
            SizedBox(height: 20,),
            Text(
              'Payment Summary',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15,),

            Row(
              children: [
                Text('Hourly Rate'),
                Spacer(),
                Text('EGP 225'),

              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Number of Hours'),
                Spacer(),
                Text('2'),

              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Wallet'),
                Spacer(),
                Text('(-)0'),

              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Total'),
                Spacer(),
                Text('EGP 450'),

              ],
            ),
            Spacer(),
            Container(
              width: double.infinity,
              color: Color(0xff388E3C),
              child: defaultTextButton(
                color: Colors.white,
                backGroundColor: Color(0xff388E3C),
                function: () {
                  for(int i = 0; i <choose.length ; i++){
                    
                  }

                },
                text: 'YALA',
              ),
            ),



          ],
        ),
      ),
    );
  }
}
