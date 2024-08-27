enum TypeEnum {
  component,
  asset,
  location;

  String iconPath() {
    if (this == TypeEnum.location) {
      return 'assets/localization_icon.svg';
    }

    if (this == TypeEnum.asset) {
      return 'assets/asset_icon.svg';
    }

    return 'assets/component_icon.svg';
  }
}

class TreeModel {
  String id;
  String name;
  TypeEnum type;
  String? parentId;
  List<TreeModel> subTree;

  TreeModel({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
    required this.subTree,
  });
}
