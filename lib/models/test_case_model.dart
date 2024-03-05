import 'dart:ui';

class TestCaseModel{
  int id;
  String title;
  String cases;
  Function? function;

  TestCaseModel({required this.title,required this.id, this.function,required this.cases});

  factory TestCaseModel.fromJson(json){
    return TestCaseModel(
      id: json['id'],
      title: json['title'],
      cases: json['cases'],
    );
  }

  toMap(){
    return {
      "id":id,
      "title":title,
      "cases":cases,
    };
  }
}

class TouchPoints{
  Offset offset;
  int duration;
  String event;
  TouchPoints({required this.offset,required this.duration,required this.event});

  factory TouchPoints.from(json){
    return TouchPoints(
      offset:Offset(json["offset"]["x"],json["offset"]["y"]) ,
      duration:  json["duration"],
      event:  json["event"],
    );
  }

  toMap(){
    return{
      "duration":duration,
      "offset":{"x":offset.dx,"y":offset.dy},
      "event":event
    };
  }
}



class LogModel{
  int caseId;
  String? status;
  String? message;
  LogModel({this.message,this.status,required this.caseId});
  factory LogModel.from(json){
    return LogModel(
      status: json["status"]??"",
      caseId: json["caseId"]??0,
      message: json["message"]??"",
    );
  }

  toMap(){
    return{
      "status":status??"",
      "message":message??"",
      "caseId":caseId??0,
    };
  }
}