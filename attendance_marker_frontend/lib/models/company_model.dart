import 'package:flutter/src/material/dropdown.dart';

import '../utils/constants/model_constants.dart';

class CompanyModel {
  final String companyId;
  final String companyName;
  final String companyLocation;

  CompanyModel({required this.companyId, required this.companyName, required this.companyLocation});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json[ModelConstants.companyId].toString(),
      companyName: json[ModelConstants.companyName].toString(),
      companyLocation: json[ModelConstants.companyLocation].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> company = <String, dynamic>{};
    company[ModelConstants.companyId] = companyId;
    company[ModelConstants.companyName] = companyName;
    company[ModelConstants.companyLocation] = companyLocation;
    return company;
  }

  // map(DropdownMenuItem<CompanyModel> Function(dynamic company) param0) {}
}
