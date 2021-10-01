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
                  builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
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
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context , index) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 140,
                                  width: double.infinity,
                                  child:   Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadiusDirectional.only(
                                                    topStart: Radius.circular(30),
                                                    topEnd: Radius.circular(30)
                                                )
                                            ),
                                            height: 140,
                                            width: 160,
                                            child: Image(
                                              fit: BoxFit.fill,
                                                image: NetworkImage(userModel["mala3eb"]["image"])
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

                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  'from: ${formatTime(num:userModel["mala3eb"][mala3ebLastIndex-index]["from"])} to: ${formatTime(num:userModel["mala3eb"][mala3ebLastIndex-index]["to"])}',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  'Field: ${userModel["mala3eb"][mala3ebLastIndex-index]["field"]}',
                                                  maxLines: 1,
                                                  style: TextStyle(

                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text('${userModel["mala3eb"][mala3ebLastIndex-index]["fees"]} EGP/hr'),
                                                Spacer(),
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
                                                          children: [
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
                                                    SizedBox(width:10),
                                                    ConditionalBuilder(
                                                      condition: (TimeOfDay.now().hour<=userModel["mala3eb"][mala3ebLastIndex-index]["from"]&&cubit.compareDates(date1:userModel["mala3eb"][mala3ebLastIndex-index]["date"],date2:DateFormat("yyyy-MM-dd").format(DateTime.now()))==0)||cubit.compareDates(date1:userModel["mala3eb"][mala3ebLastIndex-index]["date"],date2:DateFormat("yyyy-MM-dd").format(DateTime.now()))==-1,
                                                      builder: (context) {
                                                        return Container(
                                                          color: Colors.red,
                                                          height: 35,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Alert(
                                                                  context: context,
                                                                  title: "Are you sure you want to cancel?",
                                                                  content: Text("Cancellation Policy"),
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
                                                                                "randomNumber":""
                                                                              });
                                                                        }
                                                                        userModel["mala3eb"].removeAt(mala3ebLastIndex-index);
                                                                        cubit.updateUserData(data: {
                                                                          "mala3eb":userModel["mala3eb"]
                                                                        });
                                                                        Navigator.pop(context);
                                                                      },
                                                                      width: 120,
                                                                      color: Colors.red,
                                                                    ),
                                                                  ]
                                                              ).show();
                                                            },

                                                            child: Text('Cancel',
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
                                    ],
                                  ),
                                )
                            ),
                            separatorBuilder: (context , index) => myDivider(),
                            itemCount: userModel["mala3eb"].length
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
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
                                SizedBox(width: 5,),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: defaultColor,
                                  child: TextButton(
                                    onPressed:() {
                                      cubit.changeToTournaments();
                                    },
                                    child: Text(
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
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
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
                                          //clipBehavior: Clip.antiAliasWithSaveLayer,
                                          // decoration: BoxDecoration(
                                          //     borderRadius: BorderRadiusDirectional.only(
                                          //         topStart: Radius.circular(30),
                                          //         topEnd: Radius.circular(30)
                                          //     )
                                          // ),
                                          height: 100,
                                          width: 120,
                                          child: Image(
                                              fit: BoxFit.contain,
                                              image: AssetImage('assets/images/empty_ball.png')
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start ,
                                            children: [
                                              Text(
                                                '${cubit.userTournaments[userTournamentsLastIndex-index]["name"]}',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              Text(
                                                'Your Team name: ${userModel["teamNames"][userTournamentsLastIndex-index]}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text('${cubit.userTournaments[userTournamentsLastIndex-index]["schoolName"]}'),
                                              Text(
                                                '${cubit.userTournaments[userTournamentsLastIndex-index]["date"]}',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'from: ${cubit.userTournaments[userTournamentsLastIndex-index]["from"]} to: ${cubit.userTournaments[userTournamentsLastIndex-index]["to"]}',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Container(
                                                    color: defaultColor,
                                                    height: 35,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Alert(
                                                          context: context,
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
                                                                cubit.userTournaments[userTournamentsLastIndex-index]["Participants"].remove(userModel["teamNames"][userTournamentsLastIndex-index]);
                                                                cubit.updateTournamentsData(tournamentId: userModel["tournamentIds"][userTournamentsLastIndex-index], data: {
                                                                  "Participants": cubit.userTournaments[userTournamentsLastIndex-index]["Participants"],
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
                                                      child: Text('Details',
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
                                                      onPressed: () {  },

                                                      child: Row(
                                                        children: [
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
                          ),
                        ],
                      ),
                    ),
                  )
              );


        });

  }
}
