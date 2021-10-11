import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';


class ChoosingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          AppCubit cubit = AppCubit.get(context);
          var userModel = cubit.userModel;
          int mala3ebLastIndex = userModel["mala3eb"].length-1;
          int userTournamentsLastIndex = cubit.userTournaments.length-1;
          return ConditionalBuilder(
                  condition: cubit.isMala3eb  ,
                  builder: (context){
                    return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: defaultColor,
                                child: TextButton(
                                  onPressed:() {
                                    cubit.changeToMala3eb();
                                  },
                                  child: const Text(
                                    'Mala3eb',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.grey[300],
                                child: TextButton(
                                  onPressed:() {
                                    cubit.changeToTournaments();
                                  },
                                  child: Text(
                                    'Tournaments',
                                    style: TextStyle(
                                      color: defaultColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        ConditionalBuilder(
                          condition: userModel["mala3eb"].length>0,
                          builder:(context)=> ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context , index) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 160,
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
                                          height: 160,
                                          width: 170,
                                          child: Image(
                                            fit: BoxFit.fill,
                                              image: NetworkImage(userModel["mala3eb"][mala3ebLastIndex-index]["image"])
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start ,
                                            children: [
                                               Text(
                                                '${userModel["mala3eb"][mala3ebLastIndex-index]["schoolName"]}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color:Theme.of(context).textTheme.bodyText1!.color,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              Text(
                                                DateFormat.yMMMd().format(DateTime.parse(userModel["mala3eb"][mala3ebLastIndex-index]["date"])),
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color:Theme.of(context).textTheme.bodyText1!.color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'from: ${formatTime(num:userModel["mala3eb"][mala3ebLastIndex-index]["from"])} to: ${formatTime(num:userModel["mala3eb"][mala3ebLastIndex-index]["to"])}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'Field: ${userModel["mala3eb"][mala3ebLastIndex-index]["field"]}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                  '${userModel["mala3eb"][mala3ebLastIndex-index]["fees"]} EGP/hr',
                                                style: TextStyle(
                                                  color: Theme.of(context).textTheme.bodyText1!.color
                                                ),
                                              ),
                                              Text(
                                                'Total: ${userModel["mala3eb"][mala3ebLastIndex-index]["fees"]*(userModel["mala3eb"][mala3ebLastIndex-index]["to"]-userModel["mala3eb"][mala3ebLastIndex-index]["from"])-userModel["mala3eb"][mala3ebLastIndex - index]["payByWallet"]} EGP',
                                                style: TextStyle(
                                                    color: Theme.of(context).textTheme.bodyText1!.color
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
                                                        launch(userModel["mala3eb"][mala3ebLastIndex-index]["location"]);
                                                      },

                                                      child: Row(
                                                        children: const [
                                                          Icon(Icons.location_on ,
                                                            color: Colors.white,),
                                                          Text(
                                                              'Location',
                                                              style: TextStyle(
                                                                color:Colors.white,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width:10),
                                                  ConditionalBuilder(
                                                    condition: !userModel["mala3eb"][mala3ebLastIndex-index]["isDone"],
                                                    builder: (context) {
                                                      return Container(
                                                        color: Colors.red,
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
                                                                title: "Are you sure you want to cancel?",
                                                                content: Text(
                                                                    "Cancellation Policy",
                                                                  style: TextStyle(
                                                                    color:Theme.of(context).textTheme.bodyText1!.color
                                                                  ),
                                                                ),
                                                                buttons: [
                                                                  DialogButton(
                                                                    child: const Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                          color:Colors.white,
                                                                        )),
                                                                    onPressed: (){
                                                                      for(int i=userModel["mala3eb"][mala3ebLastIndex-index]["from"];i<userModel["mala3eb"][mala3ebLastIndex-index]["to"];i++){
                                                                        cubit.updateBookingTimeModel(
                                                                            cityId: userModel["mala3eb"][mala3ebLastIndex - index]["city"],
                                                                            schoolId: userModel["mala3eb"][mala3ebLastIndex - index]["schoolId"],
                                                                            date: userModel["mala3eb"][mala3ebLastIndex - index]["date"],
                                                                            field: userModel["mala3eb"][mala3ebLastIndex - index]["field"].toString(),
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
                                                                      // deduct from his balance if the user cancels before the 7agz day or on the same day:
                                                                      // if(cubit.diffBetweenDates(date1:DateFormat("yyyy-MM-dd").format(DateTime.now()),date2:userModel["mala3eb"][mala3ebLastIndex - index]["date"])){
                                                                      //   userModel["balance"]-= 0.5*userModel["mala3eb"][mala3ebLastIndex - index]["fees"]*(userModel["mala3eb"][mala3ebLastIndex - index]["to"]-userModel["mala3eb"][mala3ebLastIndex - index]["from"]);
                                                                      // }
                                                                      userModel["balance"]+=userModel["mala3eb"][mala3ebLastIndex - index]["payByWallet"];
                                                                      userModel["count"]--;
                                                                      userModel["mala3eb"].removeAt(mala3ebLastIndex-index);
                                                                      cubit.updateUserData(data: {
                                                                        "mala3eb":userModel["mala3eb"],
                                                                        "balance":userModel["balance"],
                                                                        "count":userModel["count"]
                                                                      });
                                                                      Navigator.pop(context);
                                                                    },
                                                                    width: 120,
                                                                    color: Colors.red,
                                                                  ),
                                                                ]
                                                            ).show();
                                                          },

                                                          child: const Text('Cancel',
                                                              style: TextStyle(
                                                                color:Colors.white,
                                                              )),
                                                        ),
                                                      );
                                                    },
                                                    fallback: (context)=>Container(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              separatorBuilder: (context , index) => myDivider(),
                              itemCount: userModel["mala3eb"].length
                          ),
                          fallback: (context)=>Center(
                            child: Text(
                                "You have not reserved any field yet. Go reserve now!",
                                style:Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize:15
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  },
                  fallback: (context) => SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: Colors.grey[300],
                                  child: TextButton(
                                    onPressed:() {
                                      cubit.changeToMala3eb();
                                    },
                                    child: Text(
                                      'Mala3eb',
                                      style: TextStyle(
                                        color: defaultColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: defaultColor,
                                  child: TextButton(
                                    onPressed:() {
                                      cubit.changeToTournaments();
                                    },
                                    child: const Text(
                                      'Tournaments',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          ConditionalBuilder(
                            condition: userModel["tournamentIds"].length>0&&cubit.userTournaments.isNotEmpty&&userModel["teamNames"].length>0,
                            builder: (context) {
                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context , index) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    child:   Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadiusDirectional.all(
                                                      Radius.circular(30)
                                                  ),
                                              ),
                                              height: 150,
                                              width: 140,
                                              child: const Image(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('assets/images/players.jpg')
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start ,
                                                children: [
                                                  Text(
                                                    '${cubit.userTournaments[userTournamentsLastIndex-index]["name"]}',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Text(
                                                    'Your Team name: ${userModel["teamNames"][userTournamentsLastIndex-index]}',
                                                    style: TextStyle(
                                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                      '${cubit.userTournaments[userTournamentsLastIndex-index]["schoolName"]}',
                                                    style: TextStyle(
                                                      color: Theme.of(context).textTheme.bodyText1!.color
                                                    ),
                                                  ),
                                                  Text(
                                                    '${cubit.userTournaments[userTournamentsLastIndex-index]["date"]}',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    'from: ${cubit.userTournaments[userTournamentsLastIndex-index]["from"]} to: ${cubit.userTournaments[userTournamentsLastIndex-index]["to"]}',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color:Theme.of(context).textTheme.bodyText1!.color,
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
                                                            Alert(
                                                              context: context,
                                                              style: AlertStyle(
                                                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                                titleStyle: TextStyle(
                                                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                                                ),
                                                                animationType: AnimationType.fromBottom,
                                                              ),
                                                              title: "${cubit.userTournaments[userTournamentsLastIndex-index]["name"]}",
                                                              content: Container(
                                                                  width: double.infinity,
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
                                                                              cubit.userTournaments[userTournamentsLastIndex-index]["pointsEntry"]==0?
                                                                              "${cubit.userTournaments[userTournamentsLastIndex-index]["feesEntry"]} EGP/team" :"${cubit.userTournaments[userTournamentsLastIndex-index]["pointsEntry"]} points/team",
                                                                              style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Theme.of(context).textTheme.bodyText1!.color
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Canceling Policy',
                                                                              style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Theme.of(context).textTheme.bodyText1!.color

                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],

                                                                  ),
                                                              ),
                                                              buttons: [
                                                                DialogButton(
                                                                  child:  const Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                        color:Colors.white,
                                                                      )),
                                                                  onPressed: () {
                                                                    cubit.userTournaments[userTournamentsLastIndex-index]["participants"].remove(userModel["teamNames"][userTournamentsLastIndex-index]);
                                                                    cubit.userTournaments[userTournamentsLastIndex-index]["currentParticipants"]--;
                                                                    cubit.updateTournamentsData(
                                                                        tournamentId: userModel["tournamentIds"][userTournamentsLastIndex-index],
                                                                        data: {
                                                                          "participants": cubit.userTournaments[userTournamentsLastIndex-index]["participants"],
                                                                          "currentParticipants":cubit.userTournaments[userTournamentsLastIndex-index]["currentParticipants"]
                                                                        });
                                                                    userModel["teamNames"].removeAt(userTournamentsLastIndex-index);
                                                                    cubit.userTournaments.removeAt(userTournamentsLastIndex-index);
                                                                    if(userModel["tournamentIds"].length==1) {
                                                                      userModel["tournamentIds"].removeAt(0);
                                                                      cubit.updateUserData(data: {
                                                                        "teamNames":userModel["teamNames"],
                                                                        "tournamentIds": []
                                                                      });
                                                                    }else{
                                                                      userModel["tournamentIds"].removeAt(userTournamentsLastIndex - index);
                                                                      cubit.updateUserData(data: {
                                                                        "teamNames":userModel["teamNames"],
                                                                        "tournamentIds": userModel["tournamentsIds"]
                                                                      });
                                                                    }
                                                                    Navigator.pop(context);
                                                                  },
                                                                  width: 120,
                                                                  color: Colors.red,
                                                                )
                                                              ],
                                                            ).show();
                                                          },
                                                          child: const Text(
                                                              'Details',
                                                              style: TextStyle(
                                                                color:Colors.white,
                                                              )),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      Container(
                                                        color: defaultColor,
                                                        height: 35,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            launch("${cubit.userTournaments[userTournamentsLastIndex-index]["location"]}");
                                                          },

                                                          child: Row(
                                                            children: const [
                                                              Icon(Icons.location_on ,
                                                                color: Colors.white,),
                                                              Text('Location',
                                                                  style: TextStyle(
                                                                    color:Colors.white,
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
                                  )
                                  ,
                                ),
                                separatorBuilder: (context , index) => myDivider() ,
                                itemCount: userModel["tournamentIds"].length,
                              );
                            },
                            fallback: (context)=>Center(
                                child:Text(
                                    "You have not applied in any tournament.Go apply now!",
                                    style:Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize:15
                                    )
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              );


        });

  }
}
