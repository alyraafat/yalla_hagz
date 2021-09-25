import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';


class MyBookingsScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          return  Scaffold(
            key: scaffoldKey,
            body: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context , index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
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
                                    Text(
                                      'Egyptian Language School',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,

                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
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
                                                                  Navigator.pop(context);

                                                                },

                                                                child: Text('CANCEL',
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
          );
        }
    );
  }
}
