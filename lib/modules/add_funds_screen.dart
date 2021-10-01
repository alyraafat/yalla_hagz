import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';

class AddFundsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Funds',
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
            defaultFormField(
                text: 'Amount',
                prefix: Icons.money,
                keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15,),
            const Text(
              'Add Funds with',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: const [
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
                children: const [
                  Icon(Icons.circle_outlined),
                  SizedBox(width: 5,),
                  Icon(Icons.money),
                  SizedBox(width: 5),
                  Text('Vodafone Cash'),
                ],
              ),

            ),
            const SizedBox(height: 20,),
            const Spacer(),
            Container(
              width: double.infinity,
              color: const Color(0xff388E3C),
              child: defaultTextButton(
                color: Colors.white,
                backGroundColor: const Color(0xff388E3C),
                function: () {
                },
                text: 'Add',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
