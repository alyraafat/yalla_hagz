import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CircularProgressIndicatorScreen(),
    );
  }
}

  class CircularProgressIndicatorScreen extends StatefulWidget {
  @override
  _CircularProgressIndicatorScreenState createState()
  {
    return _CircularProgressIndicatorScreenState();
  }
}

class _CircularProgressIndicatorScreenState extends State<CircularProgressIndicatorScreen> {
  double value  = 0;
  var x;
  int seconds = 0;
  @override
  Widget build(BuildContext context) {
    var userModel = AppCubit.get(context).userModel;
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                  children:[
                    ConditionalBuilder(
                      condition: value!=0,
                      builder: (context) {
                        return ConditionalBuilder(
                        condition: value>0&&value<1,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              color: defaultColor,
                              strokeWidth: 5,
                              value: value
                            ),
                          );
                        },
                        fallback: (context)=>Container(
                              margin: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                child: const Text("Enjoy your 7agz"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.green
                                ),
                                onPressed: ()
                                {
                                  if(x!=null){
                                    if (userModel["userId"] != cubit.bookingTimeModel["userId"]) {
                                      print("uId:$uId");
                                      print(cubit.bookingTimeModel["userId"]);
                                      showToast(
                                          text: "Sorry, someone has booked this just before you",
                                          state: ToastStates.ERROR);
                                      userModel["mala3eb"].removeAt(x);
                                      userModel["count"]--;
                                      cubit.updateUserData(data: {
                                        "mala3eb": userModel["mala3eb"],
                                        "count": userModel["count"]
                                      });
                                    } else {
                                      userModel["mala3eb"][x]["isChecked"] = true;
                                      cubit.updateUserData(data: {
                                        "mala3eb": userModel["mala3eb"]
                                      });
                                      showToast(
                                          text: "You have successfully booked from:${formatTime(num: userModel["mala3eb"][x]["from"])} to:${formatTime(num: userModel["mala3eb"][x]["to"])}",
                                          state: ToastStates.SUCCESS);
                                    }
                                  }
                                  navigateAndFinish(context, BottomNavScreen());
                                },
                              ),
                            )


                  );
                      },
                      fallback: (BuildContext context) =>Container(
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          child: const Text("Proceed"),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Colors.green
                          ),
                          onPressed: ()
                          {
                            for(int i=0;i<userModel["mala3eb"].length;i++){
                              if(!userModel["mala3eb"][i]["isChecked"]){
                                cubit.getOneBookingTimeModel(
                                  cityId:userModel["mala3eb"][i]["city"] ,
                                  schoolId: userModel["mala3eb"][i]["schoolId"],
                                  date: userModel["mala3eb"][i]["date"],
                                  field: userModel["mala3eb"][i]["field"].toString(),
                                  from: userModel["mala3eb"][i]["from"]
                                );
                                x = i;
                                break;
                              }
                            };
                            downloadData();
                            setState((){});
                          }
                        ),
                      ),
                    )
                  ]
              )
          ),
        )
    );
  }

  void downloadData(){
      Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          seconds++;
          setState((){});
          if(seconds<=11){
            value+=0.1;
            setState((){});
          }else{
            timer.cancel();
          }

        }

      );

  }
}