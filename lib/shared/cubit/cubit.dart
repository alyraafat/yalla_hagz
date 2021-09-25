
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/Network/local/cache_helper.dart';
import 'package:yalla_hagz/models/booking_time_model.dart';
import 'package:yalla_hagz/models/school_model.dart';
import 'package:yalla_hagz/modules/choosing_screen.dart';
import 'package:yalla_hagz/modules/mala3eb_screen.dart';
import 'package:yalla_hagz/modules/tournament_screen.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';

import '../constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  // bool isDark = false;
  String currentCity = "";
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
  void getUserData(){
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = value.data();
      emit(AppGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState(error));
    });
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
      getUserData();
    }).catchError((error){
      print(error.toString());
      emit(AppUpdateUserErrorState(error));
    });
  }


  List<dynamic> tournaments = [];
  void getTournamentsData(){
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

  List<List<dynamic>> schools = [];
  void getSchoolsData({
    required String cityId
  }){
    emit(AppGetSchoolsLoadingState());
    FirebaseFirestore.instance
        .collection('cities')
        .doc(cityId)
        .collection("schools")
        .get()
        .then((value) {
          schools.add(value.docs);
          emit(AppGetSchoolsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSchoolsErrorState(error));
    });
  }

  // Get One School
  var oneSchool = {};
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
        .get()
        .then((value) {
      oneSchool = value.data()!;
      emit(AppGetOneSchoolSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetOneSchoolErrorState(error));
    });
  }

  // void createTimeTable({
  //   // required String schoolId,
  //   required int courts,
  //   required int startTime,
  //   required int endTime,
  //   // required String dateOfToday,
  // }){
  //
  //    var dateOfToday = DateTime.now();
  //    int month = dateOfToday.month;
  //    int year = dateOfToday.year;
  //    int day=dateOfToday.day;
  //
  //     for(int i=1;i<=courts;i++){
  //       // schoolModel.timeTable.addAll({i:{}});
  //       for(int j=0;j<31;j++){
  //         // month = dateOfToday.month;
  //         // day = dateOfToday.day;
  //         if(j!=0) day+=1;
  //         switch(month){
  //           case 12:
  //             if(day>31) {
  //               month = 1;
  //               year+=1;
  //               day -= 31;
  //             }
  //             break;
  //           case 2:
  //             if(year!=2024||year!=2028||year!=2032||year!=2036){
  //               if(day > 28){
  //                 month = 3;
  //                 day -= 28;
  //               }
  //             }else {
  //               if (day > 29) {
  //                 month = 3;
  //                 day -= 29;
  //               }
  //             }
  //             break;
  //           case 4:case 6:case 9:case 11:
  //           if(day > 30){
  //             month++;
  //             day -= 30;
  //           }
  //           break;
  //           default:
  //             if(day > 31){
  //               month++;
  //               day -= 31;
  //             }
  //             break;
  //         }
  //         String strDay = day.toString();
  //         String strMonth = month.toString();
  //         if(day<10) strDay = "0"+strDay;
  //         if(month<10) strMonth = "0"+strMonth;
  //         // schoolModel.timeTable[i]!.addEntries();
  //         for(int z=0;z<(endTime-startTime);z++){
  //           // schoolModel.timeTable.addAll(
  //           //     {i: {DateTime.parse("$year-$strMonth-$strDay").toString():{"${startTime+z} to ${startTime+z+1}":""}}}
  //           // );
  //         }
  //       }
  //     }
  //
  //
  // }
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
        .get()
        .then((value) {
          for (var element in value.docs) {
            if(element.id == date){
              getBookingTimeModel(
                  cityId: cityId,
                  schoolId: schoolId,
                  date: date,
                  field: field,
              );
              emit(AppCheckDataInDatabaseSuccessState());
              return;
            }
          }
          createBookingTimeModel(
            fees: fees,
            schoolId: schoolId,
            field: field,
            cityId: cityId,
            date: date,
            intervals: intervals
          );

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
    getBookingTimeModel(
      schoolId: schoolId,
      field: field,
      date: date,
      cityId: cityId
    );

  }

  var startTimes =[];
  var selected = [];
  void getBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required String field,
  }){
    startTimes = [];
    selected = [];
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
        .get()
        .then((value) {
          value.docs.forEach((startTime){
            startTimes.add(startTime);
            selected.add(false);
          });
      emit(AppGetBookingTimeSuccessState());
    }
    ).catchError((error) {
      print(error.toString());
      emit(AppGetBookingTimeErrorState(error));
    }
    );
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
  void changeToInitial() {
    emit(ChoosingScreenInitialState());
  }
  void changeToTournaments() {
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

  // TournamentsScreen:
  void addTeamsToDatabase({
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
    }).catchError((error){
      emit(AppUpdateTournamentsErrorState(error));
    });

  }

}
