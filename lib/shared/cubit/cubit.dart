
import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/models/booking_time_model.dart';
import 'package:yalla_hagz/models/school_model.dart';
import 'package:yalla_hagz/modules/choosing_screen.dart';
import 'package:yalla_hagz/modules/mala3eb_screen.dart';
import 'package:yalla_hagz/modules/tournament_screen.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import '../constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  // bool isDark = false;
  String currentCity = "";
  double num = 0;
  int currentIndex = 1;
  List<String> titles = [
    '7ogozaty',
    'Yala 7agz',
    'Tournaments'
  ];
  List<Widget> screens = [
    ChoosingScreen(),
    Mala3ebScreen(),
    TournamentScreen(),
  ];

  var userModel;
  int mal3ab = 0;
  void getUserData(){
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((event) {
      userModel = event.data();
      emit(AppGetUserSuccessState());
      for(int i=0;i<userModel["mala3eb"].length;i++){
        if(compareDates(date1:userModel["mala3eb"][i]["date"],date2:DateFormat("yyyy-MM-dd").format(DateTime.now()))==0){
          mal3ab = i;
          // print(userModel["mala3eb"][i]["to"]);
          // print("now:${TimeOfDay.now().hour}");
          if(TimeOfDay.now().hour>=(userModel["mala3eb"][i]["to"]!=0?userModel["mala3eb"][i]["to"]:24)&&!userModel["mala3eb"][i]["isDone"]){
            userModel["mala3eb"][i]["isDone"] = true;
            userModel["count"]--;
            updateUserData(data: {
              "mala3eb": userModel["mala3eb"],
              "count":userModel["count"]
            });
          }
        }else if(compareDates(date1:userModel["mala3eb"][i]["date"],date2:DateFormat("yyyy-MM-dd").format(DateTime.now()))==-1&&!userModel["mala3eb"][i]["isDone"]){
          userModel["mala3eb"][i]["isDone"] = true;
          userModel["count"]--;
          updateUserData(data: {
            "mala3eb": userModel["mala3eb"],
            "count":userModel["count"]
          });
        }
      };
      getUserTournamentsData(tournamentIds: userModel["tournamentIds"]);
    });
    //     .then((value) {
    //
    //     }).catchError((error){
    //       print(error.toString());
    //       emit(AppGetUserErrorState(error));
    // });
  }

  void updateUserData({
    required Map<String, dynamic> data
  }){
    emit(AppUpdateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(data)
        .then((value) {
      emit(AppUpdateUserSuccessState());
      // getUserData();
    }).catchError((error){
      print(error.toString());
      emit(AppUpdateUserErrorState(error));
    });
  }


  List<dynamic> tournaments = [];
  void getTournamentsData(){
    tournaments = [];
    emit(AppGetTournamentsLoadingState());
    FirebaseFirestore.instance
        .collection("tournaments")
        .get()
        .then((value){
      for(int i=0;i<value.size;i++){
        tournaments.add(value.docs[i].data());
      }
      emit(AppGetTournamentsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetTournamentsErrorState(error));
    });
  }

  // Get One Tournament:
  var userTournaments = [];
  void getUserTournamentsData({
    required List<dynamic> tournamentIds
  }){
    userTournaments = [];
    emit(AppGetUserTournamentsLoadingState());
    tournamentIds.forEach((tournamentId) {
      FirebaseFirestore.instance
          .collection("tournaments")
          .doc(tournamentId)
          .get()
          .then((value) {
        userTournaments.add(value.data());
        emit(AppGetUserTournamentsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetUserTournamentsErrorState(error));
      });
    });
  }

  void updateTournamentsData({
    required String tournamentId,
    required Map<String,dynamic> data
  }){
    emit(AppUpdateTournamentsLoadingState());
    FirebaseFirestore.instance
        .collection("tournaments")
        .doc(tournamentId)
        .update(data)
        .then((value){
      emit(AppUpdateTournamentsSuccessState());
      getTournamentsData();
    }).catchError((error){
      emit(AppUpdateTournamentsErrorState(error));
    });

  }


  List<String> cities = [];
  void getCitiesData(){
    emit(AppGetCitiesLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .get()
        .then((value){
          for(int i=0;i<value.size;i++){
            cities.add(value.docs[i].id);
          }
          emit(AppGetCitiesSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppGetCitiesErrorState(error));
        });
  }

  List<dynamic> schools = [];
  void getSchoolsData({
    required String cityId
  }){
    schools = [];
    emit(AppGetSchoolsLoadingState());
    FirebaseFirestore.instance
        .collection('cities')
        .doc(cityId)
        .collection("schools")
        .orderBy("name")
        .get()
        .then((value) {
          value.docs.forEach((element) {
            schools.add(element.data());
          });
          // for(int i=0;i<value.docs.length;i++){
          //   int x = Random().nextInt(value.docs.length);
          //   var temp = schools[0][i];
          //   schools[0][i] = schools[0][x];
          //   schools[0][x] = temp;
          // }

          emit(AppGetSchoolsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSchoolsErrorState(error));
    });
  }

  // Get One School
  var oneSchool;
  void getOneSchoolData({
    required String cityId,
    required String schoolId
  }){
    emit(AppGetOneSchoolLoadingState());
    FirebaseFirestore.instance
        .collection('cities')
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .snapshots()
    .listen((event) {
      oneSchool = event.data()!;
      emit(AppGetOneSchoolSuccessState());
    });
    //     .then((value) {
    //
    // }).catchError((error){
    //   print(error.toString());
    //   emit(AppGetOneSchoolErrorState(error));
    // });
  }


  void updateSchoolData({
    required String cityId,
    required String schoolId,
    required Map<String,dynamic> data
  }){
    emit(AppUpdateSchoolLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .update(data)
        .then((value){
      emit(AppUpdateSchoolSuccessState());
      getOneSchoolData(
          cityId: cityId,
          schoolId:schoolId
      );
    }).catchError((error){
      emit(AppUpdateSchoolErrorState(error));
    });
  }

  DateTime createLastDate(){
    var dateOfToday = DateTime.now();
    int month = dateOfToday.month;
    int year = dateOfToday.year;
    int day=dateOfToday.day;
    if(month==12) {
      month = 1;
      year++;
    } else {
      month += 1;
    }
    String strDay = day.toString();
    String strMonth = month.toString();
    if(day<10) strDay = "0"+strDay;
    if(month<10) strMonth = "0"+strMonth;
    DateTime date = DateTime.parse("$year-$strMonth-$strDay");
    return date;

  }
  int days({
    required int num,
    required int year
  }){
    switch(num){
      case 1:case 3:case 5:case 7:case 8:case 10:case 12: return 31;
      case 2: {
        if(year%4==0) return 29;
        else return 28;
      }
      default: return 30;
    }
  }
  bool diffBetweenDates({
    required String date1, // greater:1, smaller:-1,equal:0
    required String date2,
  }){
    List<String> d1 = date1.split("-");
    List<String> d2 = date2.split("-");
    if(date1 == date2){return true;}
    else if(int.parse(d1[0])==int.parse(d2[0])&&int.parse(d1[1])==int.parse(d2[1])){
      if((int.parse(d2[2])-int.parse(d1[2]))==1){return true;}
    }else if(int.parse(d1[0])==int.parse(d2[0])&&(int.parse(d2[1])-int.parse(d1[1]))==1){
      int days1 = days(num:int.parse(d1[1]),year:int.parse(d1[0]));
      if(int.parse(d1[2])==days1&&int.parse(d2[2])==1){return true;}
    }else if((int.parse(d2[0])-int.parse(d1[0]))==1&&int.parse(d2[1])==1&&int.parse(d1[1])==12&&int.parse(d2[2])==1&&int.parse(d1[2])==31){
      return true;
    }
    return false;
}
  int compareDates({
  required String date1, // greater:1, smaller:-1,equal:0
  required String date2,
  }){
      List<String> d1 = date1.split("-");
      List<String> d2 = date2.split("-");
      if(date1==date2) return 0;
      else if(int.parse(d1[0])>int.parse(d2[0])) return 1;
      else if(int.parse(d1[0])<int.parse(d2[0])) return -1;
      else {
        if(int.parse(d1[1])>int.parse(d2[1])) return 1;
        else if(int.parse(d1[1])<int.parse(d2[1])) return -1;
        else{
          if(int.parse(d1[2])>int.parse(d2[2])) return 1;
          else return -1;
        }
      }
  }

  String dateToDay({
    required String date
  }){
    String day = "";
    int dayNumber = DateTime.parse(date).weekday;
    switch(dayNumber){
      case 1: day = "Monday";break;
      case 2: day = "Tuesday";break;
      case 3: day = "Wednesday";break;
      case 4: day = "Thursday";break;
      case 5: day = "Friday";break;
      case 6: day = "Saturday";break;
      case 7: day = "Sunday";break;
    }
    return day;
  }

  List<List<int>> timeTable =[];
  List<List<int>> createTimeTable({
    required List<dynamic> intervals
  }){
    List<List<int>> timeTable = [];
    for(int i=0;i<intervals[intervals.length-1];i++){
      for(int j=0;j<intervals.length-1;j+=2){
        var diff;
        if(intervals[j+1]>intervals[j]) {
          diff = intervals[j+1]-intervals[j];
        } else {
          diff = (intervals[j+1]+12)-(intervals[j]-12);
        }
        for(int k=0;k<diff;k++){
          if(intervals[j]+k+1==24&&intervals[j]+k==23) {
            timeTable.add([intervals[j]+k,0]);
          } else if(intervals[j]+k==24) {
            timeTable.add([0,intervals[j]+k+1-24]);
          } else if(intervals[j]+k>24) {
            timeTable.add([intervals[j]+k-24,intervals[j]+k+1-24]);
          } else {
            timeTable.add([intervals[j]+k,intervals[j]+k+1]);
          }
        };
      }
    }
    print(timeTable);
    return timeTable;
  }
  var startTimes =[];
  var selected = [];
  var booked = [];

  void checkDateInDataBase({
    required String date,
    required String cityId,
    required String schoolId,
    required String field,
    required int fees,
    required List<dynamic> intervals
  }){
    emit(AppCheckDataInDatabaseLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .orderBy("from")
        .get()
        .then((value) {
          if(value.docs.isNotEmpty) {
            getBookingTimeModels(
                cityId: cityId,
                date: date,
                schoolId: schoolId,
                field: field
            );
          }
          else {
            createBookingTimeModel(
              fees: fees,
              schoolId: schoolId,
              field: field,
              cityId: cityId,
              date: date,
              intervals: intervals
            );
          }
          emit(AppCheckDataInDatabaseSuccessState());
    }).catchError((error){
      print(error.toString);
      emit(AppCheckDataInDatabaseErrorState(error));
    });
  }

  void createBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required int fees,
    required String field,
    required List<dynamic> intervals
  }){
    timeTable = createTimeTable(intervals: intervals);
    timeTable.forEach((list){
      BookingTimeModel bookingTimeModel = BookingTimeModel(
        to: list[1],
        userId: "",
        from: list[0],
        isDone: false,
        fees: fees,
        isBooked: false,
        userPhone: "",
        userName: "",
        randomNumber: '',
        depositPaid: false,
        bookingDate: "",
        isDeposit: false,
        pay: 0
      );
      emit(AppCreateBookingTimeLoadingState());
      FirebaseFirestore.instance
          .collection("cities")
          .doc(cityId)
          .collection("schools")
          .doc(schoolId)
          .collection("fields")
          .doc(field)
          .collection("bookingDay")
          .doc(date)
          .collection("bookingTime")
          .doc(list[0].toString())
          .set(bookingTimeModel.toMap())
          .then((value) {
        emit(AppCreateBookingTimeSuccessState());
      }
      ).catchError((error) {
        print(error.toString());
        emit(AppCreateBookingTimeErrorState(error));
      });
    });
    getBookingTimeModels(
        cityId: cityId,
        field: field,
        schoolId: schoolId,
        date: date
    );

  }

  //Get one booking time model:
  var bookingTimeModel = {};
  void getOneBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required String field,
    required int from,
  }){
    emit(AppGetOneBookingTimeLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .doc(from.toString())
        .get()
        .then((value) {
          bookingTimeModel = value.data()!;
          print(bookingTimeModel);
          emit(AppGetOneBookingTimeSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppGetOneBookingTimeErrorState(error));
        });
  }

  void getBookingTimeModels({
    required String cityId,
    required String schoolId,
    required String date,
    required String field,
  }){

    emit(AppGetBookingTimeLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .orderBy("from")
        .snapshots()
        .listen((event) {
          startTimes = [];
          selected = [];
          booked=[];
          event.docs.forEach((startTime){
            if(compareDates(date1:date,date2:DateFormat("yyyy-MM-dd").format(DateTime.now()))==0){
              if(TimeOfDay.now().hour>=startTime.data()["from"]&&!startTime.data()["isDone"]){
                updateBookingTimeModel(
                    cityId: cityId,
                    schoolId: schoolId,
                    date: date,
                    field: field,
                    from: startTime.data()["from"].toString(),
                    data: {
                      "isDone": true
                    });
              }
            }else if(compareDates(date1:date,date2:DateFormat("yyyy-MM-dd").format(DateTime.now()))==-1){
              if(!startTime.data()["isDone"]){
                updateBookingTimeModel(
                    cityId: cityId,
                    schoolId: schoolId,
                    date: date,
                    field: field,
                    from: startTime.data()["from"].toString(),
                    data: {
                      "isDone": true
                    });
              }
            }
            if(!startTime.data()["isBooked"]&&!startTime.data()["isDone"]) {
              startTimes.add(startTime.data());
              selected.add(false);
            }else if(startTime.data()["isBooked"]){
              booked.add(startTime.data());
            }
          });
          emit(AppGetBookingTimeSuccessState());
        });
  }

  void updateBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required String field,
    required String from,
    required Map<String,dynamic> data,
  }){
    emit(AppUpdateBookingTimeLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .doc(from)
        .update(data)
        .then((value) {
          emit(AppUpdateBookingTimeSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppUpdateBookingTimeErrorState(error));
        });
  }
  var offers = [];
  void getOffersData(){
    emit(AppGetOffersLoadingState());
    FirebaseFirestore.instance
        .collection("offers")
        .orderBy("points")
        .get()
        .then((value) {
          value.docs.forEach((id){
            offers.add(id.data());
          });
          emit(AppGetOffersSuccessState());
        })
        .catchError((error){
          print(error.toString());
          emit(AppGetOffersErrorState(error));
    });
  }
  void changeIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  // void changeAppMode({bool? fromShared}) {
  //   if (fromShared != null) {
  //     isDark = fromShared;
  //     emit(AppChangeModeState());
  //   }
  //   else {
  //     isDark = !isDark;
  //     CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) =>
  //         emit(AppChangeModeState()));
  //   }
  // }

  void search(){
    emit(AppMala3ebSearchState());
  }
  //PaymentScreen:
  bool creditCard = false;
  void creditCardSelection(){
    isCash = false;
    vodaCash = false;
    creditCard = !creditCard;
    emit(VodaCashState());
  }
  bool isCash = false;
  void cashSelection(){
    isCash = !isCash;
    creditCard = false;
    vodaCash = false;
    emit(CashState());
  }
  bool vodaCash = false;
  void vodaCashSelection(){
    isCash = false;
    creditCard = false;
    vodaCash = !vodaCash;
    emit(VodaCashState());
  }
  bool isWallet = false;
  void walletSelection(){
    isWallet = !isWallet;
    emit(WalletState());
  }

  //FriendsScreen:

  void changeToMyFriends() {
    emit(MyFriendsState());
  }
  void changeToRequests() {
    emit(MyFriendRequestsState());
  }
  void changeToSearch() {
    emit(MyFriendsSearchState());
  }

  // SchoolScreen:

  void changeSchool() {
    emit(SchoolScreenChangeState());
  }
  void changeNotify() {
    emit(SchoolScreenNotifyState());
  }
  void changeField() {
    emit(SchoolScreenFieldChangeState());
  }
  void changeDate() {
    emit(SchoolScreenChangeDateState());
  }
  void changeCardColor() {
    emit(SchoolScreenChangeCardColorState());
  }

  //ChoosingScreen:
  bool isMala3eb = true;
  void changeToMala3eb() {
    isMala3eb = true;
    emit(ChoosingScreenMala3ebState());
  }
  void changeToTournaments() {
    isMala3eb = false;
    emit(ChoosingScreenTournamentsState());
  }
  void changeTo() {
    emit(ChoosingScreenLoadingState());
  }

  //Mala3ebScreen:
  void changeCity() {
    emit(Mala3ebScreenChangeCityState());
  }
  void cityLoading() {
    emit(Mala3ebScreenLoadingState());
  }

  // CircularProgressIndicator Screen
  double value = 0;
  void downloadData(){
    Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) {
              if (value < 1) {
                value += 0.1;
                emit(CircularProgressIndicatorValueChangeState());
              } else {
                timer.cancel();
              }
            }
    );
  }
}


