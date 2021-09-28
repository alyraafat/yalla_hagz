import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/modules/after_7agz_rate_screen.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel!=null,
          builder: (context) {
            return ConditionalBuilder(
              condition: cubit.userModel["mala3eb"][cubit.mal3ab]["isDone"]&&cubit.userModel["mala3eb"][cubit.mal3ab]["hasRated"],
              builder: (context)=>BottomNavScreen(),
              fallback: (context)=>After7agzRateScreen(),
            );
          },
          fallback: (context)=>Center(
              child:CircularProgressIndicator(
            color:defaultColor,
          )),
        );
      },
    );
  }
}

