import 'dart:convert';

class LocationsModel {
  final String id;
  final String name;
  final String? parentId;

  LocationsModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    if (parentId != null) {
      result.addAll({'parentId': parentId});
    }

    return result;
  }

  factory LocationsModel.fromMap(Map<String, dynamic> map) {
    return LocationsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      parentId: map['parentId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationsModel.fromJson(String source) =>
      LocationsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LocationsModel(id: $id, name: $name, parentId: $parentId)';
}
