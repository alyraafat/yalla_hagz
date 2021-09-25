import 'dart:core';

class Mala3ebModel{
  late String mala3ebId;
  late String schoolId;
  late String date;

  Mala3ebModel(
      {
        required this.schoolId,
        required this.mala3ebId,
        required this.date,
      }
      );

  Mala3ebModel.fromJson(Map<String, dynamic> json){
    schoolId = json['schoolId'];
    date = json['date'];
    mala3ebId = json['mala3ebId'];

  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      "schoolId":schoolId,
      "mala3ebId":mala3ebId,
    };
  }
}