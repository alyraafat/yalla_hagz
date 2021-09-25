import 'dart:core';

import 'participant_model.dart';

class TournamentModel{
  late String name;
  late String tournamentId;
  late double fees;
  late String schoolId;
  late String date;
  late List<ParticipantModel> participants;
  late String policy;

  TournamentModel(
      {
        required this.name,
        required this.tournamentId,
        required this.fees,
        required this.schoolId,
        required this.date,
        required this.policy,
        required this.participants,
      }
      );

  TournamentModel.fromJson(Map<String, dynamic> json){
    tournamentId = json['tournamentId'];
    name = json['name'];
    fees = json['fees'];
    schoolId = json['schoolId'];
    date = json['dates'];
    policy = json['policy'];
    participants = json['participants'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      "tournamentId":tournamentId,
      "fees":fees,
      "schoolId":schoolId,
      "date":date,
      "policy":policy,
      "participants":participants,
    };
  }
}