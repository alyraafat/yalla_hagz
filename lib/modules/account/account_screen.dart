import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';
import 'changepassword.dart';
class AccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        var userModel = AppCubit.get(context).userModel;
        return Scaffold(
            appBar: AppBar(
                title: const Text(
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
                  Row(
                    children: [
                      const Icon(
                          Icons.people_outline
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height:20),
                  Row(
                    children: [
                      const Icon(
                          Icons.phone_android
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mobile number',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '+2${userModel["phone"]}',
                            style: TextStyle(
                                color: Colors.grey[500]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height:20),
                  Row(
                    children: [
                      const Icon(
                          Icons.email_outlined
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userModel["email"],
                            style: TextStyle(
                                color: Colors.grey[500]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, ChangePasswordScreen());
                    },
                    child: Row(
                      children: const [
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
                  const SizedBox(height: 15,),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {  },
                            child: const Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                )
                            ),
                          ),
                          const Text(
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
