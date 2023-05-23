import 'package:attendance_marker_frontend/models/user_model.dart';

import '../utils/constants/model_constants.dart';

class AttendanceModel {
  String? attendanceId;
  String? date;
  UserModel? userModel;
  String? startTime;
  String? endTime;
  String? workedHours;

  AttendanceModel(this.attendanceId, this.date, this.userModel, this.startTime, this.endTime, this.workedHours);

  AttendanceModel.fromJson(Map<String, dynamic> json)
    : attendanceId = json[ModelConstants.attendanceId],
      date = json[ModelConstants.date],
      userModel = json[ModelConstants.userModel],
      startTime = json[ModelConstants.startTime],
      endTime = json[ModelConstants.endTime],
      workedHours = json[ModelConstants.workedHours];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> attendance = <String, dynamic>{};
    attendance[ModelConstants.attendanceId] = attendanceId;
    attendance[ModelConstants.date] = date;
    attendance[ModelConstants.userModel] = userModel;
    attendance[ModelConstants.startTime] = startTime;
    attendance[ModelConstants.endTime] = endTime;
    attendance[ModelConstants.workedHours] = workedHours;
    return attendance;
  }

}
