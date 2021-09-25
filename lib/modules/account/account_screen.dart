import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import 'change_email_ecreen.dart';
import 'change_mobile_number_screen.dart';
import 'change_name_screen.dart';
import 'change_password_screen.dart';

class AccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        var userModel = AppCubit.get(context).userModel;
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    'Account',
                    style: TextStyle(
                        color: Color(0xff388E3C),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    )
                )
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, ChangeNameScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.people_outline
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              userModel!["name"],
                              style: TextStyle(
                                  color: Colors.grey[500]
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.edit,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, ChangeMobileNumberScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.phone_android
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile number',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '+2${userModel["phone"]}',
                              style: TextStyle(
                                  color: Colors.grey[500]
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.edit,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, ChangeEmailScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.email_outlined
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              userModel["email"],
                              style: TextStyle(
                                  color: Colors.grey[500]
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.edit,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, ChangePasswordScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.lock_outline_rounded
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.edit,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: double.infinity,
                  ),
                  SizedBox(height: 15,),
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
            )
        );
      }
    );
  }
}
