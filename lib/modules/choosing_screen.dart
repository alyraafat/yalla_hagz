import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';


class ChoosingScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          AppCubit cubit = AppCubit.get(context);
          var userModel = cubit.userModel;
          return Scaffold(
              key: scaffoldKey,
              body: ConditionalBuilder(
                  condition: state is ChoosingScreenInitialState  ,
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
                                            //clipBehavior: Clip.antiAliasWithSaveLayer,
                                            // decoration: BoxDecoration(
                                            //     borderRadius: BorderRadiusDirectional.only(
                                            //         topStart: Radius.circular(30),
                                            //         topEnd: Radius.circular(30)
                                            //     )
                                            // ),
                                            height: 140,
                                            width: 160,
                                            child: defaultCarouselSlider(),
                                            // child: Image(
                                            //   fit: BoxFit.cover,
                                            //     image: NetworkImage("https://image.made-in-china.com/2f0j00NQzGaAiBOYcg/Synthetic-Grass-for-Indoor-Soccer-Field-M60-.jpg")
                                            // ),
                                          ),
                                          SizedBox(width: 10,),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start ,
                                              children: [
                                                const Text(
                                                  'Egyptian Language School',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,

                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(height: 10,),
                                                Text(
                                                  '4/7/2002',
                                                  maxLines: 1,
                                                  style: TextStyle(

                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  'from: 10pm to: 4pm',
                                                  maxLines: 1,
                                                  style: TextStyle(

                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  'Field 1',
                                                  maxLines: 1,
                                                  style: TextStyle(

                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text('300'),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                      color: defaultColor,
                                                      height: 35,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          isBottomSheetOpen = true;
                                                          scaffoldKey.currentState!.showBottomSheet((context) => Container(
                                                              width: double.infinity,
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Text(
                                                                    'Egyptian Language School',
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                      fontSize: 25,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  SizedBox(height:10),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(12.0),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          'Location',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Date',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Time',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '300 LE',
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
                                                                        SizedBox(height: 10,),
                                                                        Container(
                                                                          height: 40,
                                                                          width: double.infinity,
                                                                          color: Colors.red,
                                                                          child: TextButton(
                                                                            onPressed: () {
                                                                              // cubit.cancelCourt();
                                                                              Navigator.pop(context);

                                                                            },

                                                                            child: Text(
                                                                                'CANCEL',
                                                                                style: TextStyle(
                                                                                  color:Colors.white,
                                                                                )),
                                                                          ),
                                                                        )

                                                                      ],
                                                                    ),
                                                                  ),


                                                                ],

                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: Colors.grey[300],
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(50), topLeft: Radius.circular(50)),
                                                              )
                                                          ));
                                                        },

                                                        child: Text('Details',
                                                            style: TextStyle(
                                                              color:Colors.white,
                                                            )),
                                                      ),
                                                    ),
                                                    SizedBox(width:10),
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
                            ),
                            separatorBuilder: (context , index) => myDivider(),
                            itemCount: 5
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
                                      cubit.changeToInitial();
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
                                                'Champions League',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,

                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Text('Egyptian Language School'),
                                              Text(
                                                '4/7/2002',
                                                maxLines: 1,
                                                style: TextStyle(

                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'from: 10pm to: 4pm',
                                                maxLines: 1,
                                                style: TextStyle(

                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                'Field 1',
                                                maxLines: 1,
                                                style: TextStyle(

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
                                                        isBottomSheetOpen = true;
                                                        scaffoldKey.currentState!.showBottomSheet((context) => Container(
                                                            width: double.infinity,
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(
                                                                  'Champions League',
                                                                  style: TextStyle(
                                                                    fontSize: 30,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                SizedBox(height:10),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(12.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        'School: Egyptain Language School',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            color: Colors.black
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        'Date',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            color: Colors.black
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        'Time',
                                                                        style: TextStyle(
                                                                            fontSize: 16,
                                                                            color: Colors.black
                                                                        ),
                                                                      ),
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
                                                                      Container(
                                                                        height: 40,
                                                                        width: double.infinity,
                                                                        color: Colors.red,
                                                                        child: TextButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);

                                                                          },

                                                                          child: Text(
                                                                              'Cancel',
                                                                              style: TextStyle(
                                                                                color:Colors.white,
                                                                              )),
                                                                        ),
                                                                      )

                                                                    ],
                                                                  ),
                                                                ),


                                                              ],

                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[300],
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius.circular(50), topLeft: Radius.circular(50)),
                                                            )
                                                        ));
                                                      },

                                                      child: Text('Details',
                                                          style: TextStyle(
                                                            color:Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
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
                            itemCount: 10,
                          ),
                        ],
                      ),
                    ),
                  )
              )
          );

        });

  }
}
