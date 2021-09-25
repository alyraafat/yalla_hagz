import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import 'search_screen.dart';
class Mala3ebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int currentIndex=10000000;
    var cities = AppCubit.get(context).cities;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          var schools = AppCubit.get(context).schools;
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConditionalBuilder(
                  condition: cities.isNotEmpty,
                  builder: (context) => Column(
                      children: [
                        Container(
                          height: 50,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context , index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: (currentIndex == index)? defaultColor:Colors.grey[300],
                                child: TextButton(
                                  onPressed:() {
                                    currentIndex = index ;
                                    AppCubit.get(context).currentCity = cities[currentIndex];
                                    AppCubit.get(context).getSchoolsData(cityId: cities[currentIndex]);
                                  },
                                  child: Text(
                                    cities[index],
                                    style: TextStyle(
                                      color: (currentIndex == index)? Colors.white:defaultColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context , index) => const SizedBox(width: 5,),
                            itemCount: cities.length ,
                          ),
                        ),
                        ConditionalBuilder(
                            condition: currentIndex!=10000000,
                            builder: (context) => ConditionalBuilder(
                              condition: state is! AppGetSchoolsLoadingState,
                              builder: (context) {
                                return Column(
                                  children: [
                                    const SizedBox(height:15),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 8
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          "${cities[currentIndex]} Schools",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:15),
                                    ConditionalBuilder(
                                        condition: state is! AppGetSchoolsLoadingState && schools!=null,
                                        builder: (context) => Container(
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context,index) => buildSchool(context,schools[currentIndex][index].data()),
                                              separatorBuilder: (context,index) => Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 8
                                                ),
                                                child: myDivider(),
                                              ),
                                              itemCount: schools[currentIndex].length
                                          ),
                                        ), fallback: (BuildContext context) => const Center(child:CircularProgressIndicator())
                                    ),
                                  ],
                                );
                              },
                              fallback: (context) => Center(child: CircularProgressIndicator(
                                color: defaultColor,
                              )),
                            ),
                            fallback: (context) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text("Please choose a location"),
                                ) ,
                              ]
                            )
                        )
                      ]
                  ),
                  fallback: (context) => Center(child:const CircularProgressIndicator()),
                ),
              ),
            ),
          );
        }
    );
  }
}
