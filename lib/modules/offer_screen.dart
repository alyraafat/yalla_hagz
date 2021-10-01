import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        var offers = AppCubit.get(context).offers;
        var userModel = AppCubit.get(context).userModel;
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Offers',
                style: TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text('My Points: ${userModel!["points"]} ',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: const [
                    //       Text(
                    //         'Offers:',
                    //         style: TextStyle(
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 15),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , index) => Container(
                          height: 100,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 35,
                                child: Text(
                                  "${offers[index]["points"]} points",
                                  style: const TextStyle(
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${offers[index]["name"]}",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyText1!.color
                                      ),
                                    ),
                                    Text(
                                        "${offers[index]["expiry"]}",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyText1!.color
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: defaultColor,
                                        ),
                                        height: 35,
                                        child: TextButton(
                                          onPressed: () {
                                            if(userModel["points"]>=offers[index]["points"]){
                                              Map<String, dynamic> data = {
                                                "points": userModel["points"] - offers[index]["points"],
                                                "balance": userModel["balance"] + offers[index]["price"]
                                              };
                                              AppCubit.get(context).updateUserData(data: data);
                                            }
                                          },
                                          child: const Text(
                                            'Redeem',
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ) ,
                        separatorBuilder: (context , index) => myDivider(),
                        itemCount: offers.length
                    )
                  ],
                ),
              ),
            ),
          );
      }
    );
  }
}
