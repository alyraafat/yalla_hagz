import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class ContactUsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)  {},
        builder: (context, state)  {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Contact Us',
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
                  Container(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    height: 1,
                    width: double.infinity,
                  ),
                  MaterialButton(
                    onPressed: (){
                      launch('https://flutteragency.com/how-to-create-a-hyperlink-in-a-flutter/');
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.email,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        SizedBox(width:10),
                        Text(
                            'Yalla7agz@gmail.com',
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
                  MaterialButton(
                    onPressed: (){
                      launch('https://flutteragency.com/how-to-create-a-hyperlink-in-a-flutter/');
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.facebook,
                          color: Theme.of(context).appBarTheme.iconTheme!.color
                        ),
                        SizedBox(width:10),
                        Text(
                            'Facebook',
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
                  SizedBox(height:20),
                  MaterialButton(
                    onPressed: (){
                      launch('https://flutteragency.com/how-to-create-a-hyperlink-in-a-flutter/');
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.facebook,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                        SizedBox(width:10),
                        Text(
                            'Instgram',
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
                  Container(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    height: 1,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


