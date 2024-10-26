class ParseTreeNode {
  final String value;
  List<ParseTreeNode> children;

  ParseTreeNode(this.value, [List<ParseTreeNode>? children])
      : children = children ?? [];
}