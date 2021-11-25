import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';



class CircularProgressIndicatorScreen extends StatelessWidget {
  var school;
  var date;
  var field;
  var randomNumber;
  var fromWallet;
  var fromTime;
  CircularProgressIndicatorScreen(this.school,this.date,this.field,this.randomNumber,this.fromWallet,this.fromTime);
  @override
  Widget build(BuildContext context) {
    var userModel = AppCubit.get(context).userModel;
    AppCubit cubit = AppCubit.get(context);
    cubit.bookingTimeModel = [];
    cubit.value = 0;
    cubit.sure = false;
    // cubit.addingToBookingTimeModel(
    //     field: field,
    //     date: date,
    //     fromTime: fromTime,
    //     school: school
    // );
    // for(int i=0;i<fromTime.length;i++){
    //   cubit.getOneBookingTimeModel(
    //       date:date,
    //       from: fromTime[i] ,
    //       cityId: school['cityId'],
    //       field: field.toString(),
    //       schoolId:school["schoolId"]
    //   );
    // }
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                    children:[
                      // ConditionalBuilder(
                      //   condition: cubit.value!=0,
                      //   builder: (context) {
                      //ConditionalBuilder(
                       // condition: cubit.booked.isNotEmpty,
                        //builder: (context) {
                          // print(fromTime);
                          //cubit.downloadData(
                            // fromTime: fromTime,
                            // school: school,
                            // field: field,
                            // date: date
                          //);
                      ConditionalBuilder(
                              condition: !cubit.sure,
                              builder: (context) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              onPrimary: Colors.white,
                                              primary: Colors.green
                                          ),
                                          child: const Text(
                                              "Continue"
                                          ),
                                          onPressed: (){
                                            cubit.addingToBookingTimeModel(
                                                field: field,
                                                date: date,
                                                fromTime: fromTime,
                                                school: school
                                            );
                                            cubit.changeSure();
                                          },
                                        ),
                                      ),
                                      const SizedBox(height:10),
                                      Container(
                                        margin: const EdgeInsets.all(20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              onPrimary: Colors.white,
                                              primary: Colors.red
                                          ),
                                          child: const Text(
                                              "Cancel"
                                          ),
                                          onPressed: (){
                                            for(int i=fromTime[0];i<=fromTime[fromTime.length-1];i++){
                                              cubit.updateBookingTimeModel(
                                                  cityId: school["cityId"],
                                                  schoolId: school["schoolId"],
                                                  date: date,
                                                  field: field.toString(),
                                                  from: i.toString(),
                                                  data: {
                                                    "isBooked": false,
                                                    "userId": "",
                                                    "userPhone": "",
                                                    "userName": "",
                                                    "randomNumber":"",
                                                    "isDeposit":false,
                                                    "depositPaid":false,
                                                    "bookingDate":"",
                                                    "pay": 0
                                                  });
                                            }
                                            navigateAndFinish(context, BottomNavScreen());

                                          },
                                        ),
                                      )
                                      // Container(
                                      //   margin: const EdgeInsets.all(20),
                                      //   child: CircularProgressIndicator(
                                      //     backgroundColor: Colors.grey,
                                      //     color: defaultColor,
                                      //     strokeWidth: 5,
                                      //     value: cubit.value
                                      //   ),
                                      // ),
                                      // const SizedBox(height:10),
                                      // Text(
                                      //   "Please wait for a few seconds...",
                                      //   style: Theme.of(context).textTheme.bodyText1,
                                      // )
                                    ],
                                  ),
                                );
                              },
                              fallback: (context){
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            "Press the button below to make sure that your booking was done successfully",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        const SizedBox(height:10),
                                        Container(
                                              margin: const EdgeInsets.all(20),
                                              child: ElevatedButton(
                                                child: const Text("Confirm"),
                                                style: ElevatedButton.styleFrom(
                                                    onPrimary: Colors.white,
                                                    primary: Colors.green
                                                ),
                                                onPressed: ()
                                                {
                                                  if(cubit.bookingTimeModel.isNotEmpty){
                                                    List<int> from = [];
                                                    List<int> end = [];
                                                    // int from = 10000000000000;
                                                    // int to = -1000000000000;
                                                    String error = "";
                                                    print(cubit.bookingTimeModel);
                                                    for(int i=0;i<cubit.bookingTimeModel.length;i++) {
                                                      // print(cubit.bookingTimeModel[i]);
                                                      if (userModel["userId"] != cubit.bookingTimeModel[i]["userId"]) {
                                                        error += "Sorry, someone has booked from:${formatTime(num:cubit.bookingTimeModel[i]["from"])} to:${formatTime(num:cubit.bookingTimeModel[i]["to"])} just before you"'\n';
                                                        // userModel["mala3eb"].removeAt(cubit.x);
                                                        // userModel["count"]--;
                                                        // cubit.updateUserData(data: {
                                                        //   "mala3eb": userModel["mala3eb"],
                                                        //   "count": userModel["count"]
                                                        // });
                                                      }else {
                                                        from.add(cubit.bookingTimeModel[i]["from"]);
                                                        end.add((cubit.bookingTimeModel[i]["to"]==0?24:cubit.bookingTimeModel[i]["to"]));
                                                        // if(cubit.bookingTimeModel[i]["from"]<from){
                                                        //   from = cubit.bookingTimeModel[i]["from"];
                                                        // }
                                                        // if((cubit.bookingTimeModel[i]["to"]==0?24:cubit.bookingTimeModel[i]["to"])>to){
                                                        //   to = cubit.bookingTimeModel[i]["to"]==0?24:cubit.bookingTimeModel[i]["to"];
                                                        // }
                                                      }
                                                    }
                                                    if(error!=""){
                                                      showToast(
                                                          text: error,
                                                          state: ToastStates.ERROR
                                                      );
                                                    }
                                                    // print(from);
                                                    // print(end);
                                                    if(from.isNotEmpty&&end.isNotEmpty){
                                                      from.sort();
                                                      end.sort();
                                                      String success = "";
                                                      int i=1;
                                                      while(i<from.length){
                                                        if(from[i]==end[i-1]) {
                                                          end[i-1]++;
                                                          end[i-1]= end[i-1]==0?24:end[i-1];
                                                          from.removeAt(i);
                                                          end.removeAt(i);
                                                        }else {
                                                          i++;
                                                        }
                                                      }
                                                      cubit.userModel["count"]++;
                                                      for(int j=0;j<from.length;j++){
                                                        var totalPay = (end[j] - from[j]) * school["fees"];
                                                        var fromWallet2 = totalPay < fromWallet ? totalPay : fromWallet;
                                                        cubit.userModel["mala3eb"].add({
                                                          "schoolId": school["schoolId"],
                                                          "from": from[j],
                                                          "to": (end[j] == 24 ? 0 : end[j]),
                                                          "schoolName": school["name"],
                                                          "fees": school["fees"],
                                                          "city": cubit.currentCity,
                                                          "date": date,
                                                          "field": field,
                                                          "location": school["mapLocation"],
                                                          "isDone": false,
                                                          "hasRated": false,
                                                          "isVerified": false,
                                                          "isChecked": false,
                                                          "hasWithdrawn": false,
                                                          "rating": 0,
                                                          "randomNumber": randomNumber,
                                                          "image": school["fieldsImages"][field - 1],
                                                          "payByWallet": cubit.isWallet ? fromWallet2 : 0
                                                        });
                                                        userModel["mala3eb"][cubit.x]["isChecked"] = true;
                                                        if (cubit.isWallet) {
                                                          cubit.userModel["balance"] -= fromWallet2;
                                                        }
                                                        cubit.updateUserData(data: {
                                                          "mala3eb": cubit.userModel["mala3eb"],
                                                          "balance": cubit.userModel["balance"],
                                                          "count": cubit.userModel["count"]
                                                        });

                                                        for (int i = 0; i < cubit.bookingTimeModel.length; i++) {
                                                          cubit.updateBookingTimeModel(
                                                              cityId: cubit.currentCity,
                                                              schoolId: school["schoolId"],
                                                              date: date,
                                                              field: field.toString(),
                                                              from: cubit.bookingTimeModel[i]["from"].toString(),
                                                              data: {
                                                                "pay": totalPay - (cubit.isWallet ? fromWallet2 : 0)
                                                              });
                                                        }
                                                        success+="You have successfully booked from:${formatTime(num: from[j])} to:${formatTime(num: end[j])}"'\n';
                                                      }
                                                      showToast(
                                                          text: success,
                                                          state: ToastStates.SUCCESS
                                                      );
                                                    }
                                                  }

                                                  navigateAndFinish(context, BottomNavScreen());
                                                }
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            )
                        //},
                        // fallback: (context)=> CircularProgressIndicator(
                        //   color:defaultColor
                        // ),
                      //)


                        // fallback: (BuildContext context) =>Center(
                        //   child: Container(
                        //     margin: const EdgeInsets.all(20),
                        //     child: ElevatedButton(
                        //       child: const Text("Proceed"),
                        //       style: ElevatedButton.styleFrom(
                        //           onPrimary: Colors.white,
                        //           primary: Colors.green
                        //       ),
                        //       onPressed: ()
                        //       {
                        //         // for(int i=0;i<userModel["mala3eb"].length;i++){
                        //         //   if(!userModel["mala3eb"][i]["isChecked"]){
                        //         //     int to = ((userModel["mala3eb"][i]["to"]==0)?24:userModel["mala3eb"][i]["to"]);
                        //         //     for(int j=userModel["mala3eb"][i]["from"];j<to;j++) {
                        //         //       cubit.getOneBookingTimeModel(
                        //         //           cityId: userModel["mala3eb"][i]["city"],
                        //         //           schoolId: userModel["mala3eb"][i]["schoolId"],
                        //         //           date: userModel["mala3eb"][i]["date"],
                        //         //           field: userModel["mala3eb"][i]["field"].toString(),
                        //         //           from: j
                        //         //       );
                        //         //     }
                        //         //   x = i;
                        //         //     break;
                        //         //   }
                        //         // }
                        //         cubit.downloadData();
                        //       }
                        //     ),
                        //   ),
                        // ),
                      //)
                    ]
                )
            ),
          )
      ),
    );
  }


}