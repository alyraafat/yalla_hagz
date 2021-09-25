import 'dart:core';

class ParticipantModel{
  late String participantModelId;
  late String teamName;
  late List<String> participantsIds;

  ParticipantModel(
      {
        required this.teamName,
        required this.participantsIds,
        required this.participantModelId,
      }
      );

  ParticipantModel.fromJson(Map<String, dynamic> json){
    participantsIds = json['participantsIds'];
    teamName = json['teamName'];
    participantModelId = json['participantModelId'];

  }

  Map<String, dynamic> toMap() {
    return {
      'teamName': teamName,
      "participantsIds":participantsIds,
      "participantModelId":participantModelId,
    };
  }
}