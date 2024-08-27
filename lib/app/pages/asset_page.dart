import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_test/app/models/assets_model.dart';
import 'package:tractian_test/app/models/locations_model.dart';
import 'package:tractian_test/app/models/tree_model.dart';
import 'package:tractian_test/app/repositories/remote/companies_repository_impl.dart';
import 'package:tractian_test/app/utils/process_tree_view_data.dart';

import '../core/client.dart';
import '../widgets/my_button_icon_widget.dart';

class AssetPage extends StatefulWidget {
  final String id;

  const AssetPage({
    super.key,
    required this.id,
  });

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final _repository = CompaniesRepositoryImpl(client);
  bool energyFilterActive = false;
  bool wariningFilterActive = false;
  List<LocationsModel> locations = [];
  List<TreeModel> tree = [];

  @override
  void initState() {
    super.initState();

    _initAsync();
    print(widget.id);
  }

  Future<void> _initAsync() async {
    final response = await Future.wait([
      _repository.fetchLocations(widget.id),
      _repository.fetchAssets(widget.id),
    ]);

    final locations = response[0] as List<LocationsModel>;
    final assets = response[1] as List<AssetsModel>;

    final treeData = getTree(locations, assets);

    setState(() {
      tree = treeData;
    });
  }

  void toggleEnergyFilter() {
    setState(() {
      energyFilterActive = !energyFilterActive;
    });
  }

  void toggleWarningFilter() {
    setState(() {
      wariningFilterActive = !wariningFilterActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Assets'),
        backgroundColor: const Color(0xFF17192D),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFEAEEF2),
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFEAEFF3),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      hintStyle: const TextStyle(color: Color(0xFF8E98A3)),
                      hintText: 'Buscar Ativo ou Local',
                      prefixIcon: Container(
                        width: 30,
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.fromLTRB(16, 9, 0, 9),
                        child: SvgPicture.asset(
                          'assets/search_icon.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    MyButtonIconWidget(
                      active: energyFilterActive,
                      onTap: toggleEnergyFilter,
                      title: 'Sensor de Energia',
                      iconPath: 'assets/energy_icon.svg',
                    ),
                    const SizedBox(width: 8),
                    MyButtonIconWidget(
                      active: wariningFilterActive,
                      onTap: toggleWarningFilter,
                      title: 'Crítico',
                      iconPath: 'assets/warning_icon.svg',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: tree.map((el) {
                return _generateTree(el, 14);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _generateTree(TreeModel asset, double paddingLeft) {
    if (asset.subTree.isEmpty) {
      return ListTile(
        title: Text(asset.name),
        leading: SvgPicture.asset(asset.type.iconPath()),
      );
    } else {
      return ExpansionTile(
          title: Text(asset.name),
          childrenPadding: EdgeInsets.only(left: paddingLeft),
          children: asset.subTree.map((el) {
            return _generateTree(el, paddingLeft);
          }).toList());
    }
  }
}
