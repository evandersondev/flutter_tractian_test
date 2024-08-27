import '../models/assets_model.dart';
import '../models/locations_model.dart';
import '../models/tree_model.dart';

List<TreeModel> getTree(
  List<LocationsModel> locations,
  List<AssetsModel> assets,
) {
  List<TreeModel> treeList = [];

  for (var location in locations) {
    treeList.add(
      TreeModel(
        id: location.id,
        name: location.name,
        type: TypeEnum.location,
        parentId: location.parentId,
        subTree: [],
      ),
    );
  }

  for (var asset in assets) {
    treeList.add(
      TreeModel(
        id: asset.id,
        name: asset.name,
        type: asset.sensorType != null ? TypeEnum.component : TypeEnum.asset,
        parentId: asset.locationId ?? asset.parentId,
        subTree: [],
      ),
    );
  }

  return _buildTree(treeList);
}

List<TreeModel> _buildTree(List<TreeModel> treeList) {
  List<TreeModel> rootTree = [];

  Map<String, TreeModel> treeMap = {};

  for (var item in treeList) {
    treeMap[item.id] = item;
  }

  for (var item in treeList) {
    if (item.parentId == null) {
      rootTree.add(item);
    } else {
      final parent = treeMap[item.parentId];
      if (parent != null) {
        parent.subTree.add(item);
      }
    }
  }

  for (var root in rootTree) {
    root.subTree = _buildSubTree(root, treeMap);
  }

  return rootTree;
}

List<TreeModel> _buildSubTree(
    TreeModel parent, Map<String, TreeModel> treeMap) {
  List<TreeModel> subTree = [];

  for (var item in parent.subTree) {
    item.subTree = _buildSubTree(item, treeMap);
    subTree.add(item);
  }

  return subTree;
}
