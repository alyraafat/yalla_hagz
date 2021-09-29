import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class WithdrawMoneyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state) => SafeArea(
        top: true,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Money is withdrawn from your wallet",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  width: 100,
                  height: 40,
                  color: defaultColor,
                  child: defaultTextButton(
                      function: (){
                        cubit.userModel["balance"] -= cubit.userModel["mala3eb"][cubit.mal3ab]["fees"]*(cubit.userModel["mala3eb"][cubit.mal3ab]["to"]-cubit.userModel["mala3eb"][cubit.mal3ab]["from"]);
                        cubit.userModel["mala3eb"][cubit.mal3ab]["hasWithdrawn"] = true;
                        cubit.updateUserData(data: {
                          "balance":cubit.userModel["balance"],
                          "mala3eb":cubit.userModel["mala3eb"]
                        });
                        navigateAndFinish(context, BottomNavScreen());
                      },
                      text: "Ok",
                      color: Colors.white,
                      fontSize: 20
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
