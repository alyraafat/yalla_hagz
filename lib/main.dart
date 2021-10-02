import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yalla_hagz/modules/first_screen.dart';
import 'package:yalla_hagz/modules/on_boarding_screen.dart';
import 'package:yalla_hagz/shared/my_bloc_observer.dart';
import 'package:yalla_hagz/shared/UselessCubit/useless_cubit.dart';
import 'package:yalla_hagz/shared/UselessCubit/useless_states.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';
import 'package:yalla_hagz/shared/styles.dart';
import 'Network/local/cache_helper.dart';
import 'layout/bottom_nav_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/register/cubit/cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  uId = CacheHelper.getData(key: 'uId');

  Widget startWidget;


  if(onBoarding!=null&&onBoarding!=false)
  {
  if (uId != ""&&uId!=null) {
    startWidget = FirstScreen();
  } else {
    startWidget = LoginScreen();
  }
  }else{
    startWidget = OnBoardingScreen();
  }
  runApp(
      MyApp(
          isDark,
          startWidget
      )
  );
}


class MyApp extends StatelessWidget {
  var isDark;
  final Widget startWidget;
  MyApp(
      this.isDark,
      this.startWidget
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UselessCubit()..changeAppMode(fromShared: isDark)

        ),
        BlocProvider(
            create: (context) => AppCubit()..getUserData()..getCitiesData()..getOffersData()..getTournamentsData()

        ),
        BlocProvider(
            create: (context) => LoginCubit()
        ),
        BlocProvider(
            create: (context) => RegisterCubit()..getAllUsers()
        ),
      ],
      child: BlocConsumer<UselessCubit, UselessStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: UselessCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
                future: Firebase.initializeApp(),
              builder: (context,snapshot){
                  if(snapshot.hasError){
                    print("error");
                  }
                  if(snapshot.connectionState== ConnectionState.done){
                    return startWidget;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: defaultColor,
                    ),
                  );
                  
              },
            ),
          );
        },
      ),
    );
  }
}
