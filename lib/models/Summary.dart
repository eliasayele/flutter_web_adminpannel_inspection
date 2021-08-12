// To parse this JSON data, do
//
//     final summary = summaryFromJson(jsonString);

import 'dart:convert';

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));

String summaryToJson(Summary data) => json.encode(data.toJson());

class Summary {
  Summary({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.inspections,
    required this.garages,
    required this.companies,
    required this.totalRevenue,
    required this.employes,
    required this.monthlyPassedInspections,
    required this.monthlyFailedInspections,
    required this.vehicleTypeInspections,
  });

  Companies inspections;
  Companies garages;
  Companies companies;
  Companies totalRevenue;
  Companies employes;
  List<Monthly> monthlyPassedInspections;
  List<Monthly> monthlyFailedInspections;
  List<VehicleTypeInspection> vehicleTypeInspections;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        inspections: Companies.fromJson(json["inspections"]),
        garages: Companies.fromJson(json["garages"]),
        companies: Companies.fromJson(json["companies"]),
        totalRevenue: Companies.fromJson(json["total_revenue"]),
        employes: Companies.fromJson(json["employes"]),
        monthlyPassedInspections: List<Monthly>.from(
            json["monthly_passed_inspections"].map((x) => Monthly.fromJson(x))),
        monthlyFailedInspections: List<Monthly>.from(
            json["monthly_failed_inspections"].map((x) => Monthly.fromJson(x))),
        vehicleTypeInspections: List<VehicleTypeInspection>.from(
            json["vehicle_type_inspections"]
                .map((x) => VehicleTypeInspection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inspections": inspections.toJson(),
        "garages": garages.toJson(),
        "companies": companies.toJson(),
        "total_revenue": totalRevenue.toJson(),
        "employes": employes.toJson(),
        "monthly_passed_inspections":
            List<dynamic>.from(monthlyPassedInspections.map((x) => x.toJson())),
        "monthly_failed_inspections":
            List<dynamic>.from(monthlyFailedInspections.map((x) => x.toJson())),
        "vehicle_type_inspections":
            List<dynamic>.from(vehicleTypeInspections.map((x) => x.toJson())),
      };
}

class Companies {
  Companies({
    required this.currentTotal,
    required this.currentPassed,
    required this.currentFailed,
    required this.previousTotal,
    required this.previousPassed,
    required this.previousFailed,
    required this.all,
    required this.change,
    required this.monthly,
  });

  int currentTotal;
  int currentPassed;
  int currentFailed;
  int previousTotal;
  int previousPassed;
  int previousFailed;
  int all;
  int change;
  List<Monthly> monthly;

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        currentTotal: json["current_total"],
        currentPassed: json["current_passed"],
        currentFailed: json["current_failed"],
        previousTotal: json["previous_total"],
        previousPassed: json["previous_passed"],
        previousFailed: json["previous_failed"],
        all: json["all"],
        change: json["change"],
        monthly: json["monthly"] == null
            ? []
            : List<Monthly>.from(
                json["monthly"].map((x) => Monthly.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_total": currentTotal,
        "current_passed": currentPassed,
        "current_failed": currentFailed,
        "previous_total": previousTotal,
        "previous_passed": previousPassed,
        "previous_failed": previousFailed,
        "all": all,
        "change": change,
        "monthly": monthly == null
            ? []
            : List<dynamic>.from(monthly.map((x) => x.toJson())),
      };
}

class Monthly {
  Monthly({
    required this.month,
    required this.value,
  });

  String month;
  int value;

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        month: json["month"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "value": value,
      };
}

class VehicleTypeInspection {
  VehicleTypeInspection({
    required this.vehicleType,
    required this.total,
    required this.change,
    required this.monthlyInspections,
  });

  String vehicleType;
  int total;
  int change;
  List<Monthly> monthlyInspections;

  factory VehicleTypeInspection.fromJson(Map<String, dynamic> json) =>
      VehicleTypeInspection(
        vehicleType: json["vehicle_type"],
        total: json["total"],
        change: json["change"],
        monthlyInspections: json["monthly_inspections"] == null
            ? []
            : List<Monthly>.from(
                json["monthly_inspections"].map((x) => Monthly.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vehicle_type": vehicleType,
        "total": total,
        "change": change,
        "monthly_inspections":
            List<dynamic>.from(monthlyInspections.map((x) => x.toJson())),
      };
}
