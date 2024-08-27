import 'dart:convert';

class AssetsModel {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String status;
  final String? gatewayId;
  final String? locationId;

  AssetsModel({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    required this.status,
    this.gatewayId,
    this.locationId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    if (parentId != null) {
      result.addAll({'parentId': parentId});
    }
    if (sensorId != null) {
      result.addAll({'sensorId': sensorId});
    }
    if (sensorType != null) {
      result.addAll({'sensorType': sensorType});
    }
    result.addAll({'status': status});
    if (gatewayId != null) {
      result.addAll({'gatewayId': gatewayId});
    }
    if (locationId != null) {
      result.addAll({'locationId': locationId});
    }

    return result;
  }

  factory AssetsModel.fromMap(Map<String, dynamic> map) {
    return AssetsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      parentId: map['parentId'],
      sensorId: map['sensorId'],
      sensorType: map['sensorType'],
      status: map['status'] ?? '',
      gatewayId: map['gatewayId'],
      locationId: map['locationId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetsModel.fromJson(String source) =>
      AssetsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssetsModel(id: $id, name: $name, parentId: $parentId, sensorId: $sensorId, sensorType: $sensorType, status: $status, gatewayId: $gatewayId, locationId: $locationId)';
  }
}
