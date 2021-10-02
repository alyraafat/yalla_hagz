import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';
import 'change_password.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 20.0),
                    child: Row(
                      children: [
                         Icon(
                            Icons.phone_android,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile number',
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1!.color,
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
                  ),
                  const SizedBox(height:20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Icon(
                            Icons.email_outlined,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1!.color,
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
                  ),
                  const SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      navigateTo(context, ChangePasswordScreen());
                    },
                    child: Row(
                      children:  [
                        Icon(
                            Icons.lock_outline_rounded,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).textTheme.bodyText1!.color
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).textTheme.bodyText1!.color,
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
                            child: Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                )
                            ),
                          ),
                          Text(
                              "App Version 1.0.0",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 12
                            ),
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
