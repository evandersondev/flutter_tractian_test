import 'package:tractian_test/app/models/assets_model.dart';
import 'package:tractian_test/app/models/companies_model.dart';
import 'package:tractian_test/app/models/locations_model.dart';

abstract interface class CompaniesRepository {
  Future<List<CompaniesModel>> fetchCompanies();
  Future<List<LocationsModel>> fetchLocations(String companyId);
  Future<List<AssetsModel>> fetchAssets(String companyId);
}
