import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';
import 'contact_us_screen.dart';
import 'my_friends.dart';
import 'offer_screen.dart';
import 'settings_screen.dart';
import 'wallet_screen.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) {
          var userModel = AppCubit.get(context).userModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
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
                padding: const EdgeInsets.all(5.0),
                child: Column(

                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          ),
                          child: Image(
                            image: AssetImage('assets/images/background.jpeg',),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   maxRadius: 25,
                              //   child: Text('KG'),
                              //   backgroundColor: defaultColor,
                              // ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userModel?['name']}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '+2${userModel?['phone']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${userModel?['points']} Points',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // MaterialButton(
                    //   onPressed: (){
                    //     navigateTo(context, MyFriends());
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.people_outline),
                    //       SizedBox(width:10),
                    //       Text('My Friends'),
                    //       Spacer(),
                    //       Icon(
                    //         Icons.arrow_forward_ios_outlined,
                    //         size: 15,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    MaterialButton(
                      onPressed: (){
                        navigateTo(context, WalletScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                              Icons.money,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          ),
                          SizedBox(width:10),
                          Text(
                              'Wallet',
                            style: Theme.of(context).textTheme.bodyText1
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: userModel!['balance']>=0?defaultColor:Colors.red,
                            child: Row(
                              children: [
                                SizedBox(width: 5,),
                                Text(
                                  '${userModel!['balance']} EGP',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ) ,
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        navigateTo(context, OfferScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                              Icons.redeem,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          ),
                          SizedBox(width:10),
                          Text(
                              'Redeem Offers',
                            style: Theme.of(context).textTheme.bodyText1
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        navigateTo(context, SettingsScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                              Icons.settings,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          ),
                          SizedBox(width:10),
                          Text(
                              'Settings',
                            style:Theme.of(context).textTheme.bodyText1
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        navigateTo(context, ContactUsScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                              Icons.chat,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          ),
                          SizedBox(width:10),
                          Text(
                              'Contact us',
                            style:Theme.of(context).textTheme.bodyText1
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: Theme.of(context).appBarTheme.iconTheme!.color,
                          )
                        ],
                      ),
                    ),
                  ]
                  ,
                ),
              ),
            ),
          );
        }
    );
  }
}
