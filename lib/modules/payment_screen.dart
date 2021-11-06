import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/circular_progress_indicator_screen.dart';
import 'package:yalla_hagz/modules/school_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';
import 'dart:math';
class PaymentScreen extends StatelessWidget {
  Random random = Random();
  String randomNumber = "";
  var choose;
  var school;
  var date;
  var field;
  var count;
  var fromTime;
  PaymentScreen(this.choose,this.school,this.date,this.field,this.count,this.fromTime);
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var fromWallet = choose.length*school["fees"]<cubit.userModel["balance"]?choose.length*school["fees"]:cubit.userModel["balance"];
        if(fromWallet<0){
          cubit.isWallet = true;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Payment',
              style: TextStyle(
                  color: defaultColor,
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
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      '${cubit.userModel["balance"]}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
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
                Text(
                  'Pay With',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    cubit.creditCardSelection();
                  },
                  child: Row(
                    children: [
                      !cubit.creditCard?Icon(
                          Icons.circle_outlined,
                        color: Theme.of(context).appBarTheme.iconTheme!.color,
                      ):Icon(
                        Icons.circle,
                        color: defaultColor,
                      ),
                      const SizedBox(width: 5,),
                      Icon(
                          Icons.credit_card,
                        color: Theme.of(context).appBarTheme.iconTheme!.color,
                      ),
                      const SizedBox(width: 5),
                      Text(
                          'Credit/Debit Card',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                      ),
                    ],
                  ),

                ),
                MaterialButton(
                    onPressed: () {
                      if(count>=school["policy"]){
                        cubit.isCash = false;
                        showToast(text:"Choose vodafone cash as ${school["policyStr"]}",state: ToastStates.WARNING);
                      }else{
                        cubit.cashSelection();
                      }
                    },
                    child: Row(
                      children: [
                        cubit.isCash?Icon(
                            Icons.circle,
                            color:defaultColor
                        ):Icon(
                          Icons.circle_outlined,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        const SizedBox(width: 5,),
                        Icon(
                            Icons.money,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        const SizedBox(width: 5),
                        Text(
                            'Cash',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color
                          ),
                        ),
                      ],
                    )
                ),
                MaterialButton(
                  onPressed: () {
                    cubit.vodaCashSelection();
                  },
                  child: Row(
                    children: [
                      cubit.vodaCash?Icon(
                          Icons.circle,
                          color:defaultColor
                      ):Icon(
                          Icons.circle_outlined,
                        color: Theme.of(context).appBarTheme.iconTheme!.color,
                      ),
                      const SizedBox(width: 5,),
                      Icon(
                          Icons.money,
                        color: Theme.of(context).appBarTheme.iconTheme!.color,
                      ),
                      const SizedBox(width: 5),
                      Text(
                          'Vodafone Cash',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Payment Summary',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if(!cubit.isCash&&!cubit.vodaCash&&!cubit.creditCard){
                      showToast(text:'Please choose a payment method from above',state:ToastStates.WARNING);
                    }else {
                      if(fromWallet>=0) {
                        cubit.walletSelection();
                      }
                    }
                  },
                  child: Row(
                    children: [
                      cubit.isWallet?Icon(
                          Icons.circle,
                          color:defaultColor
                      ):Icon(
                          Icons.circle_outlined,
                        color: Theme.of(context).appBarTheme.iconTheme!.color,
                      ),
                      const SizedBox(width: 5,),
                      Icon(
                          Icons.account_balance_wallet_outlined,
                        color: Theme.of(context).appBarTheme.iconTheme!.color,
                      ),
                      const SizedBox(width: 5),
                      Text(
                          'Use Wallet',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                        'Hourly Rate',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                    const Spacer(),
                    Text(
                        'EGP ${school["fees"]}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                        'Number of Hours',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                    const Spacer(),
                    Text(
                        '${choose.length}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                        'Wallet',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                    const Spacer(),
                    Text(
                        '(-)${cubit.isWallet? fromWallet:0}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                        'Total',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                    const Spacer(),
                    Text(
                        'EGP ${choose.length*school["fees"]-(cubit.isWallet? fromWallet:0)}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ConditionalBuilder(
                  condition: cubit.isCash||cubit.vodaCash||cubit.creditCard,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      color: defaultColor,
                      child: defaultTextButton(
                        color: Colors.white,
                        backGroundColor: defaultColor,
                        function: () {
                        if (cubit.userModel["count"] < 2){
                            if (cubit.userModel["balance"] >= -200) {
                              bool wasBooked = false;
                              for (int z = 0; z < fromTime.length; z++) {
                                for (int m = 0; m < cubit.booked.length; m++) {
                                  if (cubit.booked[m]["isBooked"] && cubit.booked[m]["from"] == fromTime[z]) {
                                    showToast(
                                        text:
                                        "Someone has just booked from: ${fromTime[z]} to: ${cubit.booked[m]["to"]}",
                                        state: ToastStates.ERROR
                                    );
                                    wasBooked = true;
                                    break;
                                  }
                                }
                              }
                              if (wasBooked) {
                                navigateAndFinish(context, SchoolScreen(school));
                              } else {
                                for (int j = 1; j <= 6; j++) {
                                  randomNumber += "${random.nextInt(10)}";
                                }
                                int from = 10000000000000;
                                int to = -1000000000000;
                                choose.sort();
                                bool isConsequent = true;
                                for(int j=0;j<choose.length;j++){
                                  if(j!=choose.length-1){
                                    if(cubit.startTimes[choose[j]]["to"]!=cubit.startTimes[choose[j+1]]["from"]){
                                      showToast(
                                          text: "The reservations are not consequent",
                                          state: ToastStates.ERROR
                                      );
                                      isConsequent = false;
                                      break;
                                    }
                                  }
                                }
                                if(isConsequent){
                                  bool isDeposit = false;
                                  if(count>=school["policy"]){
                                    isDeposit = true;
                                  }else{
                                    isDeposit = false;
                                  }
                                  for (int i = 0; i < choose.length; i++) {
                                    // if (cubit.startTimes[choose[i]]["from"] < from) {
                                    //   from = cubit.startTimes[choose[i]]["from"];
                                    // }
                                    // if ((cubit.startTimes[choose[i]]["to"]==0?24:cubit.startTimes[choose[i]]["to"]) > to) {
                                    //   to = cubit.startTimes[choose[i]]["to"];
                                    // }
                                    cubit.updateBookingTimeModel(
                                        cityId: cubit.currentCity,
                                        schoolId: school["schoolId"],
                                        date: date,
                                        field: field.toString(),
                                        from: cubit.startTimes[choose[i]]["from"].toString(),
                                        data: {
                                          "isBooked": true,
                                          "userId": uId,
                                          "userName": cubit.userModel["name"],
                                          "userPhone": cubit.userModel["phone"],
                                          "randomNumber": randomNumber,
                                          "isDeposit":isDeposit,
                                          "depositPaid":false,
                                          "bookingDate":DateFormat("yyyy-MM-dd").format(DateTime.now()),
                                          // "pay": choose.length*school["fees"]-(cubit.isWallet? fromWallet:0)
                                        }
                                      );
                                    }
                                    // cubit.userModel["mala3eb"].add({
                                    //   "schoolId": school["schoolId"],
                                    //   "from": from,
                                    //   "to": to,
                                    //   "schoolName": school["name"],
                                    //   "fees": school["fees"],
                                    //   "city": cubit.currentCity,
                                    //   "date": date,
                                    //   "field": field,
                                    //   "location": school["mapLocation"],
                                    //   "isDone": false,
                                    //   "hasRated": false,
                                    //   "isVerified": false,
                                    //   "isChecked": false,
                                    //   "hasWithdrawn": false,
                                    //   "rating": 0,
                                    //   "randomNumber": randomNumber,
                                    //   "image": school["fieldsImages"][field - 1],
                                    //   "payByWallet": cubit.isWallet?fromWallet:0
                                    // });
                                    // if (cubit.isWallet) {
                                    //   cubit.userModel["balance"] -= fromWallet;
                                    // }
                                    // cubit.userModel["count"]++;
                                    // cubit.updateUserData(data: {
                                    //   "mala3eb": cubit.userModel["mala3eb"],
                                    //   "balance": cubit.userModel["balance"],
                                    //   "count": cubit.userModel["count"]
                                    // });
                                    if (count > school["policy"]) {
                                      showToast(
                                          text: "You have successfully booked but you need to pay a deposit in the next 24 hours,otherwise your 7agz will be cancelled",
                                          state: ToastStates.WARNING
                                      );
                                    }
                                  cubit.daySelectedFalse();
                                  navigateAndFinish(context, CircularProgressIndicatorScreen(school,date,field,randomNumber,fromWallet,fromTime));
                                }
                                }
                            }
                            else {
                              showToast(
                                  text: "Sorry, you need to fix your negative wallet before being able to reserve",
                                  state: ToastStates.ERROR
                              );
                            }
                          }
                          else{
                              showToast(
                              text: "Sorry, you have a limit of 2 reservations",
                              state: ToastStates.ERROR);
                              }
                          },
                        text: 'YALA',
                      ),
                    );
                  },
                  fallback: (context) {
                    return Container();
                  }
                ),
              ],
            ),
          ),
        );
      },
    );

  }

}