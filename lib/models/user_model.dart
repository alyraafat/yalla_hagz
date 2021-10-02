import 'dart:core';
import 'mala3eb_model.dart';

class UserModel{
  late String email;
  late String phone;
  late String name;
  late String userId;
  late int balance;
  late int points;
  late List<String> friendIds;
  late List<Mala3ebModel> mala3eb;
  late List<String> tournamentIds;
  late List<String> teamNames;
  late bool isEmailVerified;
  late bool isPhoneVerified;
  late int count;

  UserModel(
      {
        required this.phone,
        required this.email,
        required this.name,
        required this.userId,
        required this.points,
        required this.balance,
        required this.friendIds,
        required this.mala3eb,
        required this.tournamentIds,
        required this.teamNames,
        required this.isEmailVerified,
        required this.isPhoneVerified,
        required this.count,
      }
      );

  UserModel.fromJson(Map<String, dynamic>? json){
    email = json?['email'];
    phone = json?['phone'];
    userId = json?['userId'];
    name = json?['name'];
    points = json?['points'];
    balance = json?['balance'];
    friendIds = json?['friendIds'];
    mala3eb = json?['mala3eb'];
    tournamentIds = json?['tournamentIds'];
    teamNames = json?["teamNames"];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      "email":email,
      "userId":userId,
      'points':points,
      "balance":balance,
      "friendIds":friendIds,
      "mala3eb":mala3eb,
      "tournamentIds":tournamentIds,
      "teamNames": teamNames,
      "isEmailVerified":isEmailVerified,
      "isPhoneVerified":isPhoneVerified,
      "count":count
    };
  }
}