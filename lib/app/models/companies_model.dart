import 'dart:convert';

final class CompaniesModel {
  final String id;
  final String name;

  CompaniesModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory CompaniesModel.fromMap(Map<String, dynamic> map) {
    return CompaniesModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompaniesModel.fromJson(String source) =>
      CompaniesModel.fromMap(json.decode(source));
}
