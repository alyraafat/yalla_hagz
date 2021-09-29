import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/shared/UselessCubit/useless_cubit.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import 'account/account_screen.dart';
import 'login/login_screen.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          var userModel = AppCubit.get(context).userModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Settings',
                style: TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 15
                    ),
                    child: Text(
                      userModel!["name"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),

                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: double.infinity,
                  ),
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, AccountScreen());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.people),
                        SizedBox(width:10),
                        Text('Account'),
                        Spacer(),
                        Text('Edit'),
                        SizedBox(width:10),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(height:20),
                  // MaterialButton(
                  //   onPressed: (){},
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.language),
                  //       SizedBox(width:10),
                  //       Text('Language'),
                  //       Spacer(),
                  //       Text('English'),
                  //       SizedBox(width:10),
                  //       Icon(
                  //           Icons.arrow_forward_ios_outlined,
                  //         size: 15,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height:20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15
                    ),
                    child: InkWell(
                        child: Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            SizedBox(width: 10),
                            Text(
                                'Rate the app'
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: ()=>launch('https://flutteragency.com/how-to-create-a-hyperlink-in-a-flutter/')
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      UselessCubit.get(context).changeAppMode();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.dark_mode_rounded),
                        SizedBox(width:10),
                        Text('Dark Mode'),
                        Spacer(),

                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      CacheHelper.saveData(key: "uId", value: " ");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) {
                          return false;
                        },
                      );                      },
                    child: Row(
                      children: [
                        Icon(Icons.logout_sharp),
                        SizedBox(width:10),
                        Text('Sign Out'),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: double.infinity,
                  ),
                  SizedBox(height:20),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {  },
                            child: Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                )
                            ),
                          ),
                          Text(
                              "App Version 1.0.0"
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}


