import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yalla_hagz/modules/after_7agz_rate_screen.dart';
import 'package:yalla_hagz/modules/my_profile_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class BottomNavScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AppCubit.get(context).userModel;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor, //Color(0xff38A3A5),
              elevation: 0,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                      Icons.date_range
                  ),
                  onPressed: () {
                    navigateTo(context , MyProfileScreen());
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.book
                  ),
                  label: '7ogozaty',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.sports_soccer
                  ),
                  label: 'Yala?',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.emoji_events
                  ),
                  label: 'Tournaments',
                ),

              ],
            ),
          );
        }
    );
  }
}