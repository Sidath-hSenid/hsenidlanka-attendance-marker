import 'package:attendance_marker_frontend/models/company_model.dart';
import 'package:attendance_marker_frontend/utils/constants/model_constants.dart';

class UserModel {
  
  String? userId;
  String? username;
  String? email;
  String? password;
  CompanyModel? companyModel;

  UserModel(this.userId, this.username, this.email, this.password, this.companyModel);

  UserModel.fromJson(Map<String, dynamic> json)
    : userId = json[ModelConstants.userId],
      username = json[ModelConstants.username],
      email = json[ModelConstants.email],
      password = json[ModelConstants.password],
      companyModel = json[ModelConstants.companyModel];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user[ModelConstants.userId] = userId;
    user[ModelConstants.username] = username;
    user[ModelConstants.email] = email;
    user[ModelConstants.password] = password;
    user[ModelConstants.companyModel] = companyModel;
    return user;
  }

}
