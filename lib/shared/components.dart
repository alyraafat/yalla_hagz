

import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yalla_hagz/modules/school_screen.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';

import 'constants.dart';

Widget buildSchool(context,school) => Padding(
  padding: const EdgeInsets.all(2),
  child: InkWell(
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:  const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart:Radius.circular(30),
                      topEnd:Radius.circular(30),
                    ) ,
                ),
                height: 200,
                width: double.infinity,
                child: defaultCarouselSliderNetwork(images: school['fieldsImages']),

                // child: Image(
                //   fit: BoxFit.cover,
                //     image: NetworkImage("https://image.made-in-china.com/2f0j00NQzGaAiBOYcg/Synthetic-Grass-for-Indoor-Soccer-Field-M60-.jpg")
                // ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // color: Theme.of(context).scaffoldBackgroundColor,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 7
                              ) ,
                              child: Text(
                                school["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:Theme.of(context).textTheme.bodyText1!.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            defaultRatingBar(
                                rating: school["rating"],
                                gestures: true,
                                context: context
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              school["location"],
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(
                                height: 15
                            ),
                            Text(
                              '${school["fees"]} EGP/hr',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                            )
                          ],
                        )
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    onTap: (){
      AppCubit.get(context).daySelectedFalse();
      navigateTo(context, SchoolScreen(school));
    },
  ),
);

Widget myDivider() => Container(
  color: defaultColor.withOpacity(0.7),
  height: 1,
  width: double.infinity,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function()? onPressed,
  required String text,
}) => Container(
  width: width,
  height: 50.0,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
);

Widget defaultTextButton({
  required void Function()? function,
  double? fontSize,
  required String text,
  Color? color = const Color(0xff388E3C),
  Color? backGroundColor,
}) => TextButton(
  onPressed: function,
  child: Text(
    text,
    style: TextStyle(
      color: color,
      backgroundColor: backGroundColor,
      fontSize: fontSize,
    ),
  ),
);


Widget defaultFormField({
  IconData? prefix,
  IconData? suffix,
  required String text,
  TextEditingController? controller,
  void Function(String)? onChange,
  void Function()? onTap,
  TextInputType? keyboardType,
  String? Function(String?)? validate,
  void Function()? suffixOnPressed,
  bool isObscure = false,
  required BuildContext context
}) => Container(
  decoration: BoxDecoration(
    // border: Border(
    //   bottom: BorderSide(width: 1, color:defaultColor),
    // ),
    color: Theme.of(context).scaffoldBackgroundColor,
  ),
  child: TextFormField(
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyText1!.color
    ),
    keyboardType: keyboardType,
    controller: controller,
    obscureText: isObscure,
    onChanged: onChange,
    onTap: onTap ,
    validator: validate,
    decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: defaultColor,
            )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
        ),
        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
            color: defaultColor,
          ),
          onPressed: suffixOnPressed,
        ),
        labelText: text,
        labelStyle: TextStyle(
            color: defaultColor
        )
    ),
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
String formatTime({
  required dynamic num,
}) {
  String strNum = "";
  if (num > 12) {
    strNum = "${num - 12} pm";
  } else if (num == 0) {
    strNum = "12 am";
  } else if (num == 12) {
    strNum = "12 pm";
  } else {
    strNum = "$num am";
  }
  return strNum;
}

int formatTimeInt({
  required dynamic num,
}) {
  int time = 0;
  if (num > 12) {
    time = num - 12;
  } else if (num == 0) {
    time = 12;
  } else {
    time = num;
  }
  return time;
}

void navigateAndFinish(context, widget){
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) {
      return false;
    },
  );
}
void navigateAndReplace(
    context, widget,
    ) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          result: (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget defaultRatingBar({
  required  double rating,
  required bool gestures,
  required BuildContext context
}) {
return RatingBar.builder(
      unratedColor: Colors.grey[700],
      ignoreGestures: gestures,
      glowRadius: 10,
      glowColor: defaultColor,
      itemSize: 25,
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.sports_soccer,
        color: defaultColor,
      ),
      tapOnlyMode: true,
      onRatingUpdate: (ratingNum) {
        AppCubit.get(context).num = ratingNum;
      },
  );

}


Widget defaultCarouselSliderNetwork({
  required List<dynamic> images
}) => Container(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: const BoxDecoration(
      borderRadius: BorderRadiusDirectional.only(
        topStart:Radius.circular(30),
        topEnd:Radius.circular(30),      )
  ),
  child: CarouselSlider(
    items: images.map((item) {
      return Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: defaultColor,
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ConditionalBuilder(
          condition: ServicesBinding.instance!.defaultBinaryMessenger.send('flutter/assets', Utf8Codec().encoder.convert(Uri(path: Uri.encodeFull(item)).path).buffer.asByteData())!=null,
          builder: (context) => Image.network(
              '$item',
              fit: BoxFit.cover,
            width: double.infinity,
            ),
          fallback: (context)=>Center(child:CircularProgressIndicator(
            color: defaultColor,
          )),

        ),
      );
    }).toList(),
    options: CarouselOptions(
      //height: 200,
      viewportFraction: 1.0,
      enlargeCenterPage: false,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),

  ),
);

Widget defaultCarouselSliderAsset({
  required List<dynamic> images
}) => Container(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: const BoxDecoration(
      borderRadius: BorderRadiusDirectional.all(
          Radius.circular(30)
      )
  ),
  child: CarouselSlider(
    items: images.map((item) {
      return Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: defaultColor,
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ConditionalBuilder(
          condition: ServicesBinding.instance!.defaultBinaryMessenger.send('flutter/assets', utf8.encoder.convert(Uri(path: Uri.encodeFull(item)).path).buffer.asByteData())!=null,
          builder: (context) => Image(
            image: AssetImage(
              '$item',
            ),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          fallback: (context)=>Center(child:CircularProgressIndicator(
            color: defaultColor,
          )),

        ),
      );
    }).toList(),
    options: CarouselOptions(
      //height: 200,
      viewportFraction: 1.0,
      enlargeCenterPage: false,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),

  ),
);
String adjustError(String error){
  int x = 0;
  for(int i=0;i<error.toString().length;i++){
    if(error.toString()[i]=="]") {
      x=i+1;
      break;
    }
  }
  String err = error.toString().substring(x,error.toString().length);
  return err;
}
Widget timeBuilder() => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Card(
    shape: RoundedRectangleBorder(

      borderRadius: BorderRadius.circular(30),
    ),
    elevation: 2,
    child:   Column(
      children: [
        const Text('Date, from: to: '),
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: Image(
                  image: AssetImage('assets/images/empty_ball.png')
              ),
            ),
            SizedBox(width:10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Egyptian Language School'),
                Text('Field 1'),
              ],
            ),
            Spacer(),
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.notification_important),
                  Text('Notify Me')
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);

Widget rowBuilder(school) => Container(
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
            child: Image(
              fit: BoxFit.cover,
                image: NetworkImage(school['fieldsImages'][0])
            ),
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
          ),


        ],
      ),
    ],
  ),
);

Widget tournamentsBuilder() => Container(
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
                        },

                        child: Text('Apply',
                            style: TextStyle(
                              color:Colors.white,
                            )),
                      ),
                    ),
                    SizedBox(width: 20,),
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
);

Widget myFriend() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child:   Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        end: 10,
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        child:   Row(
          children: [
            Row(
              children: [
                // Container(
                //   //clipBehavior: Clip.antiAliasWithSaveLayer,
                //   // decoration: BoxDecoration(
                //   //     borderRadius: BorderRadiusDirectional.only(
                //   //         topStart: Radius.circular(30),
                //   //         topEnd: Radius.circular(30)
                //   //     )
                //   // ),
                //   height: 100,
                //   width: 120,
                //   child: Image(
                //       fit: BoxFit.contain,
                //       image: AssetImage('assets/images/empty_ball.png')
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(
                        'Karim Gamaleldin',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Points'),
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: defaultColor,
                              ),

                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                },

                                child: Text('Invite',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: defaultColor,
                            ),
                            height: 35,
                            child: TextButton(
                              onPressed: () {  },

                              child: Text('Unfriend',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:Colors.white,
                                  )),
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
      ),
    ),
  ),
);

Widget myRequests() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child:   Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        end: 10,
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        child:   Row(
          children: [
            Row(
              children: [
                // Container(
                //   //clipBehavior: Clip.antiAliasWithSaveLayer,
                //   // decoration: BoxDecoration(
                //   //     borderRadius: BorderRadiusDirectional.only(
                //   //         topStart: Radius.circular(30),
                //   //         topEnd: Radius.circular(30)
                //   //     )
                //   // ),
                //   height: 100,
                //   width: 120,
                //   child: Image(
                //       fit: BoxFit.contain,
                //       image: AssetImage('assets/images/empty_ball.png')
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(
                        'Karim Gamaleldin',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Points'),
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: defaultColor,
                              ),

                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                },

                                child: Text('Accept',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: defaultColor,
                            ),
                            height: 35,
                            child: TextButton(
                              onPressed: () {  },

                              child: Text('Decline',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:Colors.white,
                                  )),
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
      ),
    ),
  ),
);




