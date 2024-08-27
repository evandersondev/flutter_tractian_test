class NodeModel {
  final String id;
  final String title;
  final List<NodeModel>? children;

  NodeModel({
    required this.id,
    required this.title,
    this.children,
  });

  @override
  String toString() => 'NodeModel(id: $id, title: $title, children: $children)';
}
