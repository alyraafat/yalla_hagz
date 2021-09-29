import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yalla_hagz/layout/bottom_nav_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

class RandomNumberScreen extends StatelessWidget {
  var randomNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state) =>Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                "Please enter the random number given by the admin below.",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height:15),
              Container(
                color: defaultColor,
                child: MaterialButton(
                    onPressed: (){
                      Alert(
                        context: context,
                        content: Column(
                          children: [
                            defaultFormField(
                              controller: randomNumberController,
                              prefix: Icons.format_list_numbered_outlined,
                              text: "Random Number",
                              validate: (value){
                                if(value!.isEmpty){
                                  return "This field cannot be empty";
                                }
                              }
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 100,
                              height: 40,
                              color: defaultColor,
                              child: defaultTextButton(
                                  fontSize: 15,
                                  function: (){
                                    if(randomNumberController.text==cubit.userModel["mala3eb"][cubit.mal3ab]["randomNumber"]){
                                      cubit.userModel["mala3eb"][cubit.mal3ab]["isVerified"] = true;
                                      cubit.updateUserData(data: {
                                        "mala3eb": cubit.userModel["mala3eb"]
                                      });
                                      showToast(text:"Enjoy your 7agz!!",state: ToastStates.SUCCESS);
                                      Navigator.pop(context);
                                      navigateAndFinish(context, BottomNavScreen());
                                    }else {
                                      showToast(text:"The random number you entered is not correct. Please try again!",state: ToastStates.ERROR);
                                    }
                                  },
                                  text: "Enter",
                                color: Colors.white
                              ),
                            )
                          ],
                        ),
                        buttons: []
                      ).show();
                    },
                    child: Text(
                      'Enter your random number',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
