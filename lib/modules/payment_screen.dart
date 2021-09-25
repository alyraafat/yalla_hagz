import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

import 'mala3eb_screen.dart';
import 'rating_screen.dart';


class PaymentScreen extends StatelessWidget {
  @override
  var choose;
  var school;
  var date;
  var field;
  var count;
  bool isCash = true;
  PaymentScreen(this.choose,this.school,this.date,this.field,this.count);

  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            const Text(
              'Your Credit',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  '${cubit.userModel["balance"]}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width:5),
                const Text(
                  'EGP',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            const Text(
              'Pay With',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            MaterialButton(
              onPressed: () {
                showToast(
                    text: "Unfortuently only cash is available right now",
                    state: ToastStates.WARNING);
              },
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
              onPressed: () {
                isCash = true;
                cubit.cashSelection();
              },
              child: ConditionalBuilder(
                condition: isCash,
                builder: (context) {
                  return Row(
                    children: [
                      Icon(
                          Icons.circle,
                      color: defaultColor,),
                      const SizedBox(width: 5,),
                      const Icon(Icons.money),
                      const SizedBox(width: 5),
                      const Text('Cash'),
                    ],
                  );
                },
                fallback: (context) {
                  return Row(
                    children: [
                      Icon(Icons.circle_outlined),
                      SizedBox(width: 5,),
                      Icon(Icons.money),
                      SizedBox(width: 5),
                      Text('Cash'),
                    ],
                  );
                },
              ),

            ),
            MaterialButton(
              onPressed: () {
                showToast(
                    text: "Unfortuently only cash is available right now",
                    state: ToastStates.WARNING);
              },
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
            ConditionalBuilder(
              condition: isCash,
              builder: (context) => Column(
                children: [ const Text(
                  'Payment Summary',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                  const SizedBox(height: 15,),

                  Row(
                    children: [
                      Text('Hourly Rate'),
                      Spacer(),
                      Text('EGP ${school["fees"]}'),

                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Number of Hours'),
                      Spacer(),
                      Text('${choose.length}'),

                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const Text('Wallet'),
                      const Spacer(),
                      Text('(-)${cubit.userModel["balance"]}'),

                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const Text('Total'),
                      const Spacer(),
                      Text('EGP ${choose.length*school["fees"]}'),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    color: defaultColor,
                    child: defaultTextButton(
                      color: Colors.white,
                      backGroundColor: defaultColor,
                      function: () {
                        if(isCash){
                          for (int i = 0; i < choose.length; i++) {
                            cubit.updateBookingTimeModel(
                                cityId: cubit.currentCity,
                                schoolId: school["schoolId"],
                                date: date,
                                field: field.toString(),
                                from: cubit.startTimes[choose[i]]["from"].toString(),
                                data: {"isBooked": true, "userId": uId});
                          }
                          cubit.userModel["mala3eb"].add({
                            "schoolId": school["schoolId"],
                            "from": cubit.startTimes[choose[0]]["from"],
                            "to": cubit.startTimes[choose[choose.length - 1]]["to"],
                            "schoolName": school["name"],
                            "fees": school["fees"],
                            "city": cubit.currentCity,
                            "date": date,
                            "field": field,
                            "location": school["mapLocation"]
                          });
                          cubit.updateUserData(
                              data: {"mala3eb": cubit.userModel["mala3eb"]});
                          if (count > school["policy"]) {
                            showToast(
                                text:
                                "You have successfully booked but Ta3ala 2df3 ya 7iwan ya nasab ya beheema",
                                state: ToastStates.WARNING);
                          } else {
                            showToast(
                                text: "You have successfully booked",
                                state: ToastStates.SUCCESS);
                            navigateAndFinish(context, Mala3ebScreen());
                          }
                        }
                        else {
                          showToast(
                              text: "Unfortuently only cash is available right now",
                              state: ToastStates.ERROR);

                        }
                      },
                      text: 'YALA',
                    ),
                  ),
                ],
              ),
              fallback: (context) => const SizedBox(height:10),
            ),
          ],
        ),
      ),
    );
  }
}
