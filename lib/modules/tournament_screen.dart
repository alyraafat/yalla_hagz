import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
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
          return ConditionalBuilder(
            condition: tournaments.isNotEmpty,
            builder: (context) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context , index)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(30)
                                  )
                              ),
                              height: 150,
                              width: 140,
                              child: const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/players.jpg'
                                  )
                              ),
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
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '${tournaments[index]["schoolName"]}',
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                    ),
                                  ),
                                  Text(
                                    '${tournaments[index]["date"]}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                    ),
                                  ),
                                  Text(
                                    tournaments[index]["pointsEntry"]==0?
                                    "${tournaments[index]["feesEntry"]} EGP/team" :"${tournaments[index]["pointsEntry"]} points/team",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Maximum number of teams: ${tournaments[index]["numberOfParticipants"]}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context).textTheme.bodyText1!.color,
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
                                            Alert(
                                              context: context,
                                              style: AlertStyle(
                                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                titleStyle: TextStyle(
                                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                                ),
                                                animationType: AnimationType.fromBottom,
                                              ),
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
                                                              'from: ${tournaments[index]["from"]} to: ${tournaments[index]["to"]}',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Awards: ${tournaments[index]["awards"]}',
                                                              style: TextStyle(
                                                                color: Theme.of(context).textTheme.bodyText1!.color,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      defaultFormField(
                                                          context: context,
                                                          prefix: Icons.people_rounded,
                                                        text: "Team name",
                                                        validate: (value){
                                                          if(value!.isEmpty){
                                                            return "You must write your team name";
                                                          }else{
                                                            for(String team in tournaments[index]["participants"].keys){
                                                              if(tournaments[index]["participants"][team]==AppCubit.get(context).userModel["userId"]){
                                                                return "You have already applied";
                                                              }
                                                              if(team.toLowerCase()==value.toLowerCase()){
                                                                return "This name is already taken";
                                                              }
                                                            }
                                                            teamNameController.text = value;
                                                            tournaments[index]["participants"][value] = AppCubit.get(context).userModel["userId"];
                                                            tournaments[index]["currentParticipants"]++;
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
                                                            if(tournaments[index]["pointsEntry"]!=0){
                                                              if(AppCubit.get(context).userModel["points"]>=tournaments[index]["pointsEntry"]){
                                                                AppCubit.get(context).userModel["points"]-=tournaments[index]["pointsEntry"];
                                                                AppCubit.get(context).updateTournamentsData(tournamentId: tournaments[index]["tournamentId"], data: {
                                                                  "participants":tournaments[index]["participants"],
                                                                  "currentParticipants":tournaments[index]["currentParticipants"]
                                                                });
                                                                AppCubit.get(context).userModel["tournamentIds"].add(tournaments[index]["tournamentId"]);
                                                                AppCubit.get(context).userModel["teamNames"].add(teamNameController.text);
                                                                AppCubit.get(context).updateUserData(data: {
                                                                  "tournamentIds": AppCubit.get(context).userModel["tournamentIds"],
                                                                  "teamNames": AppCubit.get(context).userModel["teamNames"],
                                                                  "points": AppCubit.get(context).userModel["points"]
                                                                });
                                                                showToast(state: ToastStates.SUCCESS, text: 'Congratulations! You have entered the tournament.');
                                                              }else {
                                                                showToast(
                                                                  text:"Your points are not enough to enter the tournament",
                                                                  state: ToastStates.ERROR
                                                                );
                                                              }
                                                            }
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
                                          onPressed: () {
                                            launch("${tournaments[index]["location"]}");
                                          },
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
                      ),
                    );
                  },
                  separatorBuilder: (context , index) => myDivider() ,
                  itemCount: tournaments.length,
                );
            },
            fallback: (context)=>Center(
                child: Text(
                    "Tournaments will be available soon!!",
                  style:Theme.of(context).textTheme.bodyText1
                )
            ),
          );

        }
    );
  }
}
