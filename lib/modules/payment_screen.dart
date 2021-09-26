import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';
class PaymentScreen extends StatelessWidget {

  var choose;
  var school;
  var date;
  var field;
  var count;
  bool isCash = false;
  bool vodaCash = true;
  PaymentScreen(this.choose,this.school,this.date,this.field,this.count);
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
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
                      if (school['Policy'] < count) {
                        isCash = true;
                        vodaCash = false;
                        cubit.cashSelection();
                      }
                      else {
                        showToast(text:"You need to pay on advance using Vodafone Cash as you choose more than the school's policy",state:ToastStates.WARNING);

                      }
                    },
                    child: Row(
                      children: [
                        isCash?Icon(
                            Icons.circle,
                            color:defaultColor
                        ):const Icon(
                          Icons.circle_outlined,
                        ),
                        SizedBox(width: 5,),
                        Icon(Icons.money),
                        SizedBox(width: 5),
                        Text('Cash'),
                      ],
                    )
                ),
                MaterialButton(
                  onPressed: () {
                    isCash = false;
                    vodaCash = true;
                    cubit.vodaCashSelection();
                  },
                  child: Row(
                    children:  [
                      vodaCash?Icon(
                          Icons.circle,
                          color:defaultColor
                      ):const Icon(
                        Icons.circle_outlined,
                      ),
                      const SizedBox(width: 5,),
                      const Icon(Icons.money),
                      const SizedBox(width: 5),
                      const Text('Vodafone Cash'),
                    ],
                  ),

                ),
                const SizedBox(height: 20,),
               ConditionalBuilder(
                 condition: isCash || vodaCash,
                 builder: (context) {
                   int fromWallet = choose.length*school["fees"] <= cubit.userModel["balance"] ? choose.length*school["fees"] : cubit.userModel["balance"]  ;

                   return Column(
                     children: [
                       const Text(
                         'Payment Summary',
                         style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                       const SizedBox(height: 15,),

                       Row(
                         children: [
                           const Text('Hourly Rate'),
                           const Spacer(),
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
                       SizedBox(height: 5,),
                       Row(
                         children: [
                           Text('Wallet'),
                           Spacer(),
                           Text('(-)${cubit.userModel["balance"]}'),

                         ],
                       ),
                       SizedBox(height: 5,),
                       Row(
                         children: [
                           Text('Total'),
                           Spacer(),
                           Text('EGP ${choose.length*school["fees"]-fromWallet}'),
                         ],
                       ),
                       Spacer(),
                       Container(
                         width: double.infinity,
                         color: const Color(0xff388E3C),
                         child: defaultTextButton(
                           color: Colors.white,
                           backGroundColor: const Color(0xff388E3C),
                           function: () {
                             int from = 10000000000000;
                             int to = -1000000000000;
                             for(int i=0; i<choose.length ; i++){
                               if(cubit.startTimes[choose[i]]["from"]<from){
                                 from = cubit.startTimes[choose[i]]["from"];
                               }
                               if(cubit.startTimes[choose[i]]["to"]>to){
                                 to = cubit.startTimes[choose[i]]["to"];
                               }
                               cubit.updateBookingTimeModel(cityId: cubit.currentCity, schoolId: school["schoolId"], date: date, field: field.toString(), from: cubit.startTimes[choose[i]]["from"].toString(), data: {
                                 "isBooked": true,
                                 "userId":uId
                               });
                             }
                             cubit.userModel["balance"] -= fromWallet;
                             cubit.updateUserData(data: {
                               "balance":cubit.userModel["balance"]
                             });
                             cubit.userModel["mala3eb"].add({
                               "schoolId":school["schoolId"],
                               "from":from,
                               "to":to,
                               "schoolName":school["name"],
                               "fees":school["fees"],
                               "city":cubit.currentCity,
                               "date": date,
                               "field": field,
                               "location":school["mapLocation"],
                               "isDone":false,
                             });
                             cubit.updateUserData(data: {
                               "mala3eb": cubit.userModel["mala3eb"]
                             });
                             showToast(text:"You have successfully booked",state:ToastStates.SUCCESS);
                             navigateAndFinish(context, BottomNavScreen());
                           },
                           text: 'YALA',
                         ),
                       ),
                     ],
                   );
                 },
                 fallback: (context) {
                   return Container();
                 } ,
               )



              ],
            ),
          ),
        );
      },
    );

  }
}