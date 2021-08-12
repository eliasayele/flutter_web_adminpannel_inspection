// To parse this JSON data, do
//
//     final completedInspections = completedInspectionsFromJson(jsonString);

import 'dart:convert';

CompletedInspections completedInspectionsFromJson(String str) =>
    CompletedInspections.fromJson(json.decode(str));

String completedInspectionsToJson(CompletedInspections data) =>
    json.encode(data.toJson());

class CompletedInspections {
  CompletedInspections({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory CompletedInspections.fromJson(Map<String, dynamic> json) =>
      CompletedInspections(
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
    required this.metaData,
    required this.data,
  });

  MetaData metaData;
  List<VehicleData> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        metaData: MetaData.fromJson(json["meta_data"]),
        data: List<VehicleData>.from(
            json["data"].map((x) => VehicleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta_data": metaData.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VehicleData {
  VehicleData({
    required this.id,
    required this.status,
    required this.isPassed,
    required this.vehicleId,
    required this.ownerId,
    required this.configId,
    required this.inspectorId,
    required this.approverId,
    required this.garageId,
    required this.driverId,
    required this.signPath,
    required this.frontImagePath,
    required this.backImagePath,
    required this.leftImagePath,
    required this.rightImagePath,
    required this.inspector,
    required this.configuration,
    required this.garage,
    required this.vehicle,
    required this.failPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String status;
  bool isPassed;
  String vehicleId;
  String ownerId;
  String configId;
  String inspectorId;
  String approverId;
  String garageId;
  String driverId;
  String signPath;
  String frontImagePath;
  String backImagePath;
  String leftImagePath;
  String rightImagePath;
  Inspector inspector;
  Configuration configuration;
  Garage garage;
  Vehicle vehicle;
  List<FailPoint> failPoints;
  DateTime createdAt;
  DateTime updatedAt;

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
        id: json["id"],
        status: json["status"],
        isPassed: json["is_passed"],
        vehicleId: json["vehicle_id"],
        ownerId: json["owner_id"],
        configId: json["config_id"],
        inspectorId: json["inspector_id"],
        approverId: json["approver_id"],
        garageId: json["garage_id"],
        driverId: json["driver_id"],
        signPath: json["sign_path"],
        frontImagePath: json["front_image_path"],
        backImagePath: json["back_image_path"],
        leftImagePath: json["left_image_path"],
        rightImagePath: json["right_image_path"],
        inspector: Inspector.fromJson(json["inspector"]),
        configuration: Configuration.fromJson(json["configuration"]),
        garage: Garage.fromJson(json["garage"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        failPoints: json["fail_points"] == null
            ? []
            : List<FailPoint>.from(
                json["fail_points"].map((x) => FailPoint.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "is_passed": isPassed,
        "vehicle_id": vehicleId,
        "owner_id": ownerId,
        "config_id": configId,
        "inspector_id": inspectorId,
        "approver_id": approverId,
        "garage_id": garageId,
        "driver_id": driverId,
        "sign_path": signPath,
        "front_image_path": frontImagePath,
        "back_image_path": backImagePath,
        "left_image_path": leftImagePath,
        "right_image_path": rightImagePath,
        "inspector": inspector.toJson(),
        "configuration": configuration.toJson(),
        "garage": garage.toJson(),
        "vehicle": vehicle.toJson(),
        "fail_points": failPoints == null
            ? []
            : List<dynamic>.from(failPoints.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Configuration {
  Configuration({
    required this.id,
    required this.version,
    required this.status,
    required this.vehicleType,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  int version;
  String status;
  String vehicleType;
  DateTime createdAt;
  DateTime updatedAt;

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
        id: json["id"],
        version: json["version"],
        status: json["status"],
        vehicleType: json["vehicle_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "status": status,
        "vehicle_type": vehicleType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class FailPoint {
  FailPoint({
    required this.id,
    required this.name,
    required this.multiSelect,
    required this.configId,
    required this.cases,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  bool multiSelect;
  String configId;
  List<Case> cases;
  DateTime createdAt;
  DateTime updatedAt;

  factory FailPoint.fromJson(Map<String, dynamic> json) => FailPoint(
        id: json["id"],
        name: json["name"],
        multiSelect: json["multi_select"],
        configId: json["config_id"],
        cases: json["cases"] == null
            ? []
            : List<Case>.from(json["cases"].map((x) => Case.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "multi_select": multiSelect,
        "config_id": configId,
        "cases": List<dynamic>.from(cases.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Case {
  Case({
    required this.id,
    required this.name,
    required this.pointId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String pointId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        id: json["id"],
        name: json["name"],
        pointId: json["point_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "point_id": pointId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Garage {
  Garage({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String phone;
  String address;
  String companyId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        companyId: json["company_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "company_id": companyId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Inspector {
  Inspector({
    required this.id,
    required this.username,
    required this.password,
    required this.phone,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.isPhoneVerified,
    required this.isPasswordReset,
    required this.role,
    required this.photo,
    required this.photoFile,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String username;
  String password;
  String phone;
  String firstName;
  String middleName;
  String lastName;
  String email;
  bool isPhoneVerified;
  bool isPasswordReset;
  String role;
  String photo;
  dynamic photoFile;
  DateTime createdAt;
  DateTime updatedAt;

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        phone: json["phone"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        isPhoneVerified: json["is_phone_verified"],
        isPasswordReset: json["is_password_reset"],
        role: json["role"],
        photo: json["photo"],
        photoFile: json["PhotoFile"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "phone": phone,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "is_phone_verified": isPhoneVerified,
        "is_password_reset": isPasswordReset,
        "role": role,
        "photo": photo,
        "PhotoFile": photoFile,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Vehicle {
  Vehicle({
    required this.plateNumber,
    required this.sideNumber,
    required this.vehicleType,
    required this.ownerId,
    required this.drivers,
    required this.owner,
    required this.manufacturer,
    required this.model,
    required this.color,
    required this.productionYear,
  });

  String plateNumber;
  String sideNumber;
  String vehicleType;
  String ownerId;
  List<Owner> drivers;
  Owner owner;
  String manufacturer;
  String model;
  String color;
  String productionYear;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        plateNumber: json["plate_number"],
        sideNumber: json["side_number"],
        vehicleType: json["vehicle_type"],
        ownerId: json["owner_id"],
        drivers:
            List<Owner>.from(json["drivers"].map((x) => Owner.fromJson(x))),
        owner: Owner.fromJson(json["owner"]),
        manufacturer: json["manufacturer"],
        model: json["model"],
        color: json["color"],
        productionYear: json["production_year"],
      );

  Map<String, dynamic> toJson() => {
        "plate_number": plateNumber,
        "side_number": sideNumber,
        "vehicle_type": vehicleType,
        "owner_id": ownerId,
        "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())),
        "owner": owner.toJson(),
        "manufacturer": manufacturer,
        "model": model,
        "color": color,
        "production_year": productionYear,
      };
}

class Owner {
  Owner({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.roles,
    required this.imageUrl,
    required this.idImageUrl,
    required this.licenseNumber,
  });

  String id;
  String fullName;
  String userName;
  String email;
  String gender;
  String phone;
  String roles;
  String imageUrl;
  String idImageUrl;
  String licenseNumber;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        fullName: json["full_name"],
        userName: json["user_name"],
        email: json["email"],
        gender: json["gender"],
        phone: json["phone"],
        roles: json["roles"],
        imageUrl: json["image_url"],
        idImageUrl: json["id_image_url"],
        licenseNumber: json["license_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "user_name": userName,
        "email": email,
        "gender": gender,
        "phone": phone,
        "roles": roles,
        "image_url": imageUrl,
        "id_image_url": idImageUrl,
        "license_number": licenseNumber,
      };
}

class MetaData {
  MetaData({
    required this.page,
    required this.perPage,
    required this.pageCount,
    required this.totalCount,
    required this.links,
  });

  int page;
  int perPage;
  int pageCount;
  int totalCount;
  List<Link> links;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        page: json["page"],
        perPage: json["per_page"],
        pageCount: json["page_count"],
        totalCount: json["total_count"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "page_count": pageCount,
        "total_count": totalCount,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Link {
  Link({
    required this.self,
    required this.first,
    required this.previous,
    required this.next,
    required this.last,
  });

  String self;
  String first;
  String previous;
  String next;
  String last;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        self: json["self"] == null ? "" : json["self"],
        first: json["first"] == null ? "" : json["first"],
        previous: json["previous"] == null ? "" : json["previous"],
        next: json["next"] == null ? "" : json["next"],
        last: json["last"] == null ? "" : json["last"],
      );

  Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "first": first == null ? null : first,
        "previous": previous == null ? null : previous,
        "next": next == null ? null : next,
        "last": last == null ? null : last,
      };
}
