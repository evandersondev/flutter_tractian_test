import 'package:dio/dio.dart';
import 'package:tractian_test/app/models/assets_model.dart';
import 'package:tractian_test/app/models/locations_model.dart';
import 'package:tractian_test/app/repositories/companies_repository.dart';

import '../../models/companies_model.dart';

final class CompaniesRepositoryImpl implements CompaniesRepository {
  final Dio _client;

  CompaniesRepositoryImpl(this._client);

  @override
  Future<List<CompaniesModel>> fetchCompanies() async {
    final response = await _client.get('/companies');

    if (response.statusCode == 200) {
      final data = response.data as List;
      final companies = data.map((e) => CompaniesModel.fromMap(e)).toList();

      return companies;
    } else {
      throw Exception('Failed to load companies');
    }
  }

  @override
  Future<List<LocationsModel>> fetchLocations(String companyId) async {
    final response = await _client.get('/companies/$companyId/locations');

    if (response.statusCode == 200) {
      final data = response.data as List;
      final locations = data.map((e) {
        return LocationsModel.fromMap(e);
      }).toList();

      return locations;
    } else {
      throw Exception('Failed to load locations');
    }
  }

  @override
  Future<List<AssetsModel>> fetchAssets(String companyId) async {
    final response = await _client.get('/companies/$companyId/assets');
    if (response.statusCode == 200) {
      final data = response.data as List;
      final assets = data.map((e) => AssetsModel.fromMap(e)).toList();

      return assets;
    } else {
      throw Exception('Failed to load assets');
    }
  }
}
