// Level 1: courts as keys
// Level 2: Days as keys
// Level 3: time as keys
// Level 4: userId as values for time
class SchoolModel{
  late String name;
  late String schoolId;
  late double fees;
  late String location;
  late String mapLocation;
  late String policy;
  late double rating;
  late int fields;
  late int startTime;
  late int endTime;
  late double profit;
  // late Map<int,Map<String,Map<String,String>>> timeTable;
  // //List<List<List<String>>>

  SchoolModel(

        // required this.name,
        // required this.schoolId,
        // required this.courts,
        // required this.fees,
        // required this.location,
        // required this.mapLocation,
        // required this.policy,
        // required this.rating,
        // required this.profit,
        // required this.startTime,
        // required this.endTime,
        // required this.timeTable
      );
  SchoolModel.fromJson(Map<String, dynamic> json){
    schoolId = json['schoolId'];
    name = json['name'];
    fields = json['fields'];
    fees = json['fees'];
    location = json['location'];
    mapLocation = json['mapLocation'];
    policy = json['policy'];
    rating = json['rating'];
    profit = json['profit'];

  }

  Map<String, dynamic> toMap() {
    return {
      // 'name': name,
      // "schoolId":schoolId,
      // "courts":courts,
      // "fees":fees,
      // "location":location,
      // "mapLocation":mapLocation,
      // "policy":policy,
      // "rating":rating,
      // "profit":profit
      // "timeTable":timeTable
    };
  }



}