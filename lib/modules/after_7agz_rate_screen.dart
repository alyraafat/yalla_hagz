import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/my_profile_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class After7agzRateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SafeArea(
                top: true,
                child: Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please rate your experience below to earn points to redeem future offers",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        SizedBox(height:20),
                        Container(
                          width:100,
                          height:40,
                          color:defaultColor,
                          child: MaterialButton(
                          onPressed: () {
                            cubit.getOneSchoolData(
                                schoolId: cubit.userModel["mala3eb"][cubit.mal3ab]["schoolId"],
                                cityId: cubit.userModel["mala3eb"][cubit.mal3ab]["city"]
                            );
                            Alert(
                                context: context,
                                content: Column(
                                    children: [
                                       Text(
                                          "Rate Your Experience from ${formatTime(num:cubit.userModel["mala3eb"][cubit.mal3ab]["from"])} to ${formatTime(num:cubit.userModel["mala3eb"][cubit.mal3ab]["to"])}!!"
                                      ),
                                      SizedBox(height:10),
                                      defaultRatingBar(
                                          rating: 0,
                                          gestures: false,
                                          context: context
                                      ),
                                      const SizedBox(height:10),
                                      defaultTextButton(
                                          function: (){
                                            cubit.oneSchool["count"]++;
                                            cubit.oneSchool["totalRating"]+=cubit.num;
                                            cubit.oneSchool["rating"] = cubit.oneSchool["totalRating"]/cubit.oneSchool["count"];
                                            cubit.updateSchoolData(
                                                cityId: cubit.userModel["mala3eb"][cubit.mal3ab]["city"],
                                                schoolId: cubit.userModel["mala3eb"][cubit.mal3ab]["schoolId"],
                                                data: {
                                                  "count":cubit.oneSchool["count"],
                                                  "rating":cubit.oneSchool["rating"],
                                                  "totalRating":cubit.oneSchool["totalRating"]
                                                }
                                            );
                                            cubit.userModel["mala3eb"][cubit.mal3ab]["hasRated"] = true;
                                            cubit.userModel["mala3eb"][cubit.mal3ab]["rating"] = cubit.num;
                                            cubit.userModel["points"]+=20*(cubit.userModel["mala3eb"][cubit.mal3ab]["to"]-cubit.userModel["mala3eb"][cubit.mal3ab]["from"]);
                                            cubit.updateUserData(data: {
                                              "mala3eb": cubit.userModel["mala3eb"],
                                              "points": cubit.userModel["points"],
                                            });
                                            Navigator.pop(context);
                                            navigateAndFinish(context,BottomNavScreen());
                                          },
                                          text: "YALA"
                                      )
                                    ]
                                ),
                                buttons:[]
                            ).show();
                            },
                              child: const Text(
                              "Rate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:20
                                ),
                              ),
                              ),
                        ),
                      ],
                    ),
                  ),
                )
            );
        }
    );
  }
}