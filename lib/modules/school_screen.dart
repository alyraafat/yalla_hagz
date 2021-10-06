import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import 'payment_screen.dart';

class SchoolScreen extends StatelessWidget {
  var school;
  int currentField = 1000000;
  var dateController = TextEditingController();
  bool dateIsEmpty = true;
  bool fieldIsEmpty = true;
  bool notify = false;
  bool buildListView = false;
  String day = "";
  SchoolScreen(this.school);
  List<int> choose = [];
  List<int> fromTime = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                navigateAndReplace(context, BottomNavScreen());
              },
            ),
          ),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        school["name"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          school["location"],
                          style: TextStyle(
                            color:Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 20
                          ),
                        ),
                        const Spacer(),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: defaultColor,
                          child: TextButton(
                            onPressed:() {
                              launch(school["mapLocation"]);
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(width:5),
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    defaultRatingBar(
                        rating: school["rating"],
                        gestures: true,
                        context: context
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "${school["name"]} offers:",
                            style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 22,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 20,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context,index) => Text(
                                    "#${school["extras"][index]}",
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                    fontSize: 16
                                  ),
                                ),
                                separatorBuilder: (context,index) => const SizedBox(width: 10,),
                                itemCount: school["extras"].length
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "Policy: ${school["policyStr"]}",
                          style:TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        ConditionalBuilder(
                          condition: currentField != 1000000 ,
                          builder: (context) {
                            return Column(
                              children: [
                                ConditionalBuilder(
                                  condition: ServicesBinding.instance!.defaultBinaryMessenger.send('flutter/assets', Utf8Codec().encoder.convert(Uri(path: Uri.encodeFull(school["fieldsImages"][currentField - 1])).path).buffer.asByteData())!=null,
                                  builder: (context) {
                                    return Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(
                                              // topStart: Radius.circular(30),
                                              // topEnd: Radius.circular(30)
                                            Radius.circular(30)
                                          )
                                      ),
                                      height: 200,
                                      width: double.infinity,
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(school["fieldsImages"][currentField - 1]) ,
                                      ),
                                    );
                                  },
                                  fallback: (context)=>Center(child: CircularProgressIndicator(
                                    color: defaultColor,
                                  )),
                                ),
                                Container(
                                  height: 50,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        color: (currentField == index+1) ? defaultColor : Colors.grey[300],
                                        child: TextButton(
                                          onPressed: () {
                                            currentField = index+1;
                                            cubit.changeField();
                                            if(school["calendar$currentField"][day]!=null&&school["calendar$currentField"][day].length != 1) {
                                              AppCubit.get(context).checkDateInDataBase(
                                                  date: dateController.text,
                                                  cityId: AppCubit.get(context).currentCity,
                                                  schoolId: school["schoolId"],
                                                  field: currentField.toString(),
                                                  fees: school["fees"],
                                                  intervals:school["calendar$currentField"][day]
                                              );
                                            }
                                          },
                                          child: Text(
                                            'Field ${index+1}',
                                            style: TextStyle(
                                              color: (currentField == index+1) ? Colors.white : defaultColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context,
                                        index) => const SizedBox(width: 5,),
                                    itemCount: school["fields"],
                                  ),
                                ),
                              ],
                            );
                          },
                          fallback: (context) {
                            return Container(
                              height: 50,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Colors.grey[300],
                                    child: TextButton(
                                      onPressed: () {
                                        currentField = index+1;
                                        cubit.changeField();
                                      },
                                      child: Text(
                                        'Field ${index+1}',
                                        style: TextStyle(
                                          color: defaultColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const SizedBox(width: 5,),
                                itemCount: school["fields"],
                              ),
                            );
                          },

                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    ConditionalBuilder(
                      condition: currentField != 1000000,
                      builder: (context) {
                        return defaultFormField(
                            context: context,
                            controller: dateController,
                            prefix: Icons.date_range,
                            text: 'Choose a Date',
                            onTap: () {
                              showRoundedDatePicker(
                                  firstDate: DateTime.now(),
                                  lastDate: AppCubit.get(context).createLastDate(),
                                  context: context,
                                  theme: ThemeData(
                                    primaryColor: Colors.white,
                                  ),
                                  styleDatePicker: MaterialRoundedDatePickerStyle(
                                    textStyleDayButton:
                                    const TextStyle(fontSize: 36, color: Colors.white),
                                    textStyleYearButton: const TextStyle(
                                      fontSize: 52,
                                      color: Colors.black,
                                    ),
                                    textStyleDayHeader: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                    textStyleCurrentDayOnCalendar: const TextStyle(
                                        fontSize: 32,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textStyleDayOnCalendar:
                                    const TextStyle(fontSize: 28, color: Colors.black),
                                    textStyleDayOnCalendarSelected: const TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textStyleDayOnCalendarDisabled: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.black),
                                    textStyleMonthYearHeader: const TextStyle(
                                        fontSize: 32,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    paddingDatePicker: const EdgeInsets.all(0),
                                    paddingMonthHeader: const EdgeInsets.all(32),
                                    paddingActionBar: const EdgeInsets.all(16),
                                    paddingDateYearHeader: const EdgeInsets.all(32),
                                    sizeArrow: 50,
                                    colorArrowNext: Colors.black,
                                    colorArrowPrevious: Colors.black,
                                    marginLeftArrowPrevious: 16,
                                    marginTopArrowPrevious: 16,
                                    marginTopArrowNext: 16,
                                    marginRightArrowNext: 32,
                                    textStyleButtonAction:
                                    const TextStyle(fontSize: 28, color: Colors.white),
                                    textStyleButtonPositive: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textStyleButtonNegative: TextStyle(
                                        fontSize: 28,
                                        color: Colors.black.withOpacity(0.5)),
                                    decorationDateSelected: BoxDecoration(
                                        color: defaultColor,
                                        shape: BoxShape.circle),
                                    backgroundPicker: Colors.white,
                                    backgroundActionBar: Colors.white,
                                    backgroundHeaderMonth: Colors.white,
                                  ),
                                  styleYearPicker: MaterialRoundedYearPickerStyle(
                                    textStyleYear:
                                    const TextStyle(fontSize: 40, color: Colors.black),
                                    textStyleYearSelected: const TextStyle(
                                        fontSize: 56,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    heightYearRow: 100,
                                    backgroundPicker: Colors.black,
                                  )).then((value) {
                                day = AppCubit.get(context).dateToDay(date: value.toString());
                                dateController.text = DateFormat("yyyy-MM-dd").format(value!);
                                if(school["calendar$currentField"][day].length != 1) {
                                  AppCubit.get(context).checkDateInDataBase(
                                      date: dateController.text,
                                      cityId: AppCubit.get(context).currentCity,
                                      schoolId: school["schoolId"],
                                      field: currentField.toString(),
                                      fees: school["fees"],
                                      intervals:school["calendar$currentField"][day]);
                                }
                                AppCubit.get(context).changeDate();
                              });

                            });
                      }, fallback: (BuildContext context) {
                      return Container();
                    },
                    ),
                    const SizedBox(height: 10),
                    ConditionalBuilder(
                      condition: dateController.text.isNotEmpty,
                      builder: (context) => ConditionalBuilder(
                        condition:school["calendar$currentField"][day].length != 1&&AppCubit.get(context).startTimes.isNotEmpty,
                        builder: (context) {
                          return Column(
                            children: [
                              const Text('Times:'),
                              ConditionalBuilder(
                                condition: state is! AppGetBookingTimeLoadingState&&state is! AppCreateBookingTimeLoadingState,
                                builder: (context) {
                                  return ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => ConditionalBuilder(
                                        condition:true ,
                                        builder: (context) {
                                          int from  = AppCubit.get(context).startTimes[index]["from"];
                                          int to = AppCubit.get(context).startTimes[index]["to"];
                                          String strFrom = formatTime(num: from);
                                          String strTo = formatTime(num: to);
                                          return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                      cubit.selected[index] = !cubit.selected[index];
                                                      cubit.changeCardColor();
                                                      if (cubit.selected[index]) {
                                                        choose.add(index);
                                                        fromTime.add(AppCubit.get(context).startTimes[index]["from"]);
                                                        count++;
                                                      } else {
                                                        for (int i = 0; i < choose.length; i++) {
                                                          if (choose[i] == index) {
                                                            choose.removeAt(i);
                                                            fromTime.remove(AppCubit.get(context).startTimes[index]["from"]);
                                                            count--;
                                                          }
                                                        }
                                                      }
                                                    },
                                                  child: Card(
                                                    color: cubit.selected[index] ? defaultColor.withOpacity(0.8) : Theme.of(context).scaffoldBackgroundColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    elevation: 2,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            '$day ${DateFormat.yMMMd().format(DateTime.parse(dateController.text))}, from: $strFrom to: $strTo',
                                                          style: TextStyle(
                                                            color:Theme.of(context).textTheme.bodyText1!.color
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              child: const Image(
                                                                  image: AssetImage(
                                                                      'assets/images/empty_ball.png'
                                                                  )
                                                              ),
                                                            ),
                                                            const SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                    school["name"],
                                                                  style: TextStyle(
                                                                    color: Theme.of(context).textTheme.bodyText1!.color
                                                                  ),
                                                                ),
                                                                Text(
                                                                    'Field $currentField',
                                                                  style: TextStyle(
                                                                      color: Theme.of(context).textTheme.bodyText1!.color
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                        },
                                        fallback: (context) => Container(),
                                      ),
                                      separatorBuilder: (context, index) => myDivider(),
                                      itemCount: AppCubit.get(context).startTimes.length
                                  );
                                },
                                fallback:(context) => Center(child:CircularProgressIndicator(
                                  color: defaultColor,
                                ))
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ConditionalBuilder(
                                    condition: count != 0,
                                    builder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      color: const Color(0xff388E3C),
                                      child: defaultTextButton(
                                        color: Colors.white,
                                        backGroundColor: const Color(0xff388E3C),
                                        function: () {
                                          if(count>3){
                                            showToast(
                                                text:"You a have limit of 3 hours",
                                                state:ToastStates.WARNING
                                            );
                                          }else {
                                            bool flag = false;
                                            for(int i=0;i<AppCubit.get(context).booked.length;i++){
                                              if(uId==AppCubit.get(context).booked[i]["userId"]){
                                                showToast(
                                                    text:"You already reserved in this school on ${dateController.text}",
                                                    state:ToastStates.WARNING
                                                );
                                                flag = true;
                                                break;
                                              }
                                            }
                                            if(!flag) {
                                              navigateTo(context, PaymentScreen(
                                                  choose, school,
                                                  dateController.text,
                                                  currentField, count,
                                                  fromTime
                                              )
                                              );
                                            }
                                          }

                                        },
                                        text: 'YALA',
                                      ),
                                    );
                                  },
                                  fallback: (context) {
                                    return Container(
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: defaultTextButton(
                                        color: defaultColor,
                                        backGroundColor: Colors.grey[300],
                                        function: () {
                                          showToast(text:"Please choose a reservation",state:ToastStates.WARNING);
                                        },
                                        text: 'YALA',
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ],
                          );
                        },
                        fallback: (context)=>Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                              "No reservations on $day ${dateController.text} field $currentField",
                            style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color
                            ),
                          ),
                        ),
                      ),
                      fallback: (context) => Container()
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
