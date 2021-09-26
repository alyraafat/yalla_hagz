import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';


class TournamentScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var teamNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          AppCubit cubit = AppCubit.get(context);
          var tournaments = AppCubit.get(context).tournaments;
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context , index)
              {
                // AppCubit.get(context).getOneSchoolData(cityId: tournaments[index]["cityId"], schoolId: tournaments[index]["schoolId"]);
                // var oneSchool = AppCubit.get(context).oneSchool;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              //clipBehavior: Clip.antiAliasWithSaveLayer,
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadiusDirectional.only(
                              //         topStart: Radius.circular(30),
                              //         topEnd: Radius.circular(30)
                              //     )
                              // ),
                              height: 100,
                              width: 120,
                              child: const Image(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/images/empty_ball.png')),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${tournaments[index]["name"]}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('${tournaments[index]["schoolName"]}'),
                                  Text(
                                    '${tournaments[index]["date"]}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'from: ${tournaments[index]["from"]} to: ${tournaments[index]["to"]}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        color: defaultColor,
                                        height: 35,
                                        child: TextButton(
                                          onPressed: () {
                                            // scaffoldKey.currentState!
                                            //     .showBottomSheet((context) =>
                                            //         Container(
                                            //             width: double.infinity,
                                            //             child: Form(
                                            //               key: formKey,
                                            //               child: Column(
                                            //                 mainAxisSize:
                                            //                     MainAxisSize.min,
                                            //                 children: [
                                            //                   Text(
                                            //                     '${tournaments[index]["name"]}',
                                            //                     style: const TextStyle(
                                            //                       fontSize: 30,
                                            //                       color: Colors
                                            //                           .black,
                                            //                       fontWeight:
                                            //                           FontWeight
                                            //                               .bold,
                                            //                     ),
                                            //                   ),
                                            //                   const SizedBox(
                                            //                       height: 10
                                            //                   ),
                                            //                   Padding(
                                            //                     padding:
                                            //                         const EdgeInsets.all(12.0),
                                            //                     child: Column(
                                            //                       crossAxisAlignment:
                                            //                           CrossAxisAlignment
                                            //                               .start,
                                            //                       children: [
                                            //                         Text(
                                            //                           'School: ${tournaments[index]["schoolName"]}',
                                            //                           style: const TextStyle(
                                            //                               fontSize: 16,
                                            //                               color: Colors.black),
                                            //                         ),
                                            //                         Text(
                                            //                           '${tournaments[index]["date"]}',
                                            //                           style: const TextStyle(
                                            //                               fontSize: 16,
                                            //                               color: Colors.black
                                            //                           ),
                                            //                         ),
                                            //                         Text(
                                            //                           'from: ${tournaments[index]["from"]} to: ${tournaments[index]["to"]}',
                                            //                           style: const TextStyle(
                                            //                               fontSize: 16,
                                            //                               color: Colors.black),
                                            //                         ),
                                            //                         const Text(
                                            //                           'Entry requirements',
                                            //                           style: TextStyle(
                                            //                               fontSize: 16,
                                            //                               color: Colors.black),
                                            //                         ),
                                            //                         ConditionalBuilder(
                                            //                           condition: tournaments[index]["pointsEntry"]==0,
                                            //                           builder: (context) {
                                            //                             return Text(
                                            //                               '${tournaments[index]["fees"]} EGP',
                                            //                               style: const TextStyle(
                                            //                                   fontSize: 16,
                                            //                                   color: Colors.black
                                            //                               ),
                                            //                             );
                                            //                           },
                                            //                           fallback: (context){
                                            //                             return Text(
                                            //                               '${tournaments[index]["pointsEntry"]} points',
                                            //                               style: const TextStyle(
                                            //                                   fontSize: 16,
                                            //                                   color: Colors.black
                                            //                               ),
                                            //                             );
                                            //                           }
                                            //                         ),
                                            //                         const SizedBox(
                                            //                           height: 10,
                                            //                         ),
                                            //                         defaultFormField(
                                            //                           prefix: Icons.people_rounded,
                                            //                           text: "Team name",
                                            //                           validate: (value){
                                            //                             if(value!.isEmpty){
                                            //                               return "You must write your team name";
                                            //                             }else{
                                            //                               for(String team in tournaments[index]["Participants"].keys){
                                            //                                 if(tournaments[index]["Participants"][team]==AppCubit.get(context).userModel["userId"]){
                                            //                                   return "You have already applied";
                                            //                                 }
                                            //                                 if(team.toLowerCase()==value.toLowerCase()){
                                            //                                   return "This name is already taken";
                                            //                                 }
                                            //                               }
                                            //                               teamNameController.text = value;
                                            //                               tournaments[index]["Participants"][value] = AppCubit.get(context).userModel["userId"];
                                            //                             }
                                            //                           }
                                            //                         ),
                                            //                         const SizedBox(
                                            //                           height: 10,
                                            //                         ),
                                            //                         Container(
                                            //                           height: 40,
                                            //                           width: double.infinity,
                                            //                           color: defaultColor,
                                            //                           child: TextButton(
                                            //                             onPressed: () {
                                            //                               if(formKey.currentState!.validate()){
                                            //                                 AppCubit.get(context).updateTournamentsData(tournamentId: tournaments[index]["tournamentId"], data: {
                                            //                                   "Participants":tournaments[index]["Participants"]
                                            //                                 });
                                            //                                 AppCubit.get(context).userModel["tournamentIds"].add(tournaments[index]["tournamentId"]);
                                            //                                 AppCubit.get(context).userModel["teamNames"].add(teamNameController.text);
                                            //                                 AppCubit.get(context).updateUserData(data: {
                                            //                                   "tournamentIds": AppCubit.get(context).userModel["tournamentIds"],
                                            //                                   "teamNames": AppCubit.get(context).userModel["teamNames"]
                                            //                                 });
                                            //                                 showToast(state: ToastStates.SUCCESS, text: 'Congratulations! You have entered the tournament.');
                                            //                                 Navigator.pop(context);
                                            //                               }
                                            //                             },
                                            //                             child: const Text(
                                            //                                 'Apply',
                                            //                                 style:
                                            //                                     TextStyle(
                                            //                                   color:
                                            //                                       Colors.white,
                                            //                                 )),
                                            //                           ),
                                            //                         )
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //             decoration:
                                            //                 BoxDecoration(
                                            //               color:
                                            //                   Colors.grey[300],
                                            //               borderRadius:
                                            //                   const BorderRadius.only(
                                            //                       topRight: Radius
                                            //                           .circular(
                                            //                               50),
                                            //                       topLeft: Radius
                                            //                           .circular(
                                            //                               50)),
                                            //             )));
                                            Alert(
                                              context: context,
                                              title: "${tournaments[index]["name"]}",
                                              content: Container(
                                                width: double.infinity,
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(height:10),
                                                      Padding(
                                                        padding: const EdgeInsets.all(12.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Entry requirements',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.black
                                                              ),
                                                            ),
                                                            Text(
                                                              'Canceling Policy',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.black
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      defaultFormField(
                                                        prefix: Icons.people_rounded,
                                                        text: "Team name",
                                                        validate: (value){
                                                          if(value!.isEmpty){
                                                            return "You must write your team name";
                                                          }else{
                                                            for(String team in tournaments[index]["Participants"].keys){
                                                              if(tournaments[index]["Participants"][team]==AppCubit.get(context).userModel["userId"]){
                                                                return "You have already applied";
                                                              }
                                                              if(team.toLowerCase()==value.toLowerCase()){
                                                                return "This name is already taken";
                                                              }
                                                            }
                                                            teamNameController.text = value;
                                                            tournaments[index]["Participants"][value] = AppCubit.get(context).userModel["userId"];
                                                          }
                                                        }
                                                      ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                      DialogButton(
                                                        child:  const Text(
                                                            'Apply',
                                                            style: TextStyle(
                                                              color:Colors.white,
                                                            )),
                                                        onPressed: () {
                                                          if(formKey.currentState!.validate()){
                                                            AppCubit.get(context).updateTournamentsData(tournamentId: tournaments[index]["tournamentId"], data: {
                                                              "Participants":tournaments[index]["Participants"]
                                                            });
                                                            AppCubit.get(context).userModel["tournamentIds"].add(tournaments[index]["tournamentId"]);
                                                            AppCubit.get(context).userModel["teamNames"].add(teamNameController.text);
                                                            AppCubit.get(context).updateUserData(data: {
                                                              "tournamentIds": AppCubit.get(context).userModel["tournamentIds"],
                                                              "teamNames": AppCubit.get(context).userModel["teamNames"]
                                                            });
                                                            showToast(state: ToastStates.SUCCESS, text: 'Congratulations! You have entered the tournament.');
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        width: 120,
                                                        color: defaultColor,
                                                      )
                                                    ],

                                                  ),
                                                ),
                                              ),
                                              buttons: []
                                            ).show();
                                          },
                                          child: const Text(
                                              'Details',
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        color: defaultColor,
                                        height: 35,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                              ),
                                              Text('Location',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context , index) => myDivider() ,
              itemCount: tournaments.length,
            );

        }
    );
  }
}
