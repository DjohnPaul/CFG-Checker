import 'tree_node.dart';
import 'tree_widget.dart';
import 'package:flutter/material.dart';

class ParseTree extends StatelessWidget {
  final List<String> nonterminalsUsed;
  final List<List<String>> productionUsed;

  ParseTree(this.nonterminalsUsed, this.productionUsed);

  @override
  Widget build(BuildContext context) {
    ParseTreeNode rootNode = createParseTree(nonterminalsUsed, productionUsed);

    printTreeStructure(rootNode);

    return ParseTreeWidget(rootNode: rootNode);
  }

  void printTreeStructure(ParseTreeNode node, [int depth = 0]) {
    print('${' ' * depth}- ${node.value}');
    for (var child in node.children) {
      printTreeStructure(child, depth + 2);
    }
  }
}

ParseTreeNode createParseTree(List<String> nonterminalsUsed, List<List<String>> productionUsed) {
  int productionIndex = 0;

  ParseTreeNode buildTree(String nonTerminal) {
    ParseTreeNode currentNode = ParseTreeNode(nonTerminal);

    if (productionIndex >= productionUsed.length || productionUsed[productionIndex].isEmpty) {
      currentNode.children.add(ParseTreeNode('ɛ'));
      return currentNode;
    }

    List<String> currentProduction = productionUsed[productionIndex];
    productionIndex++;

    for (var symbol in currentProduction) {
      if (nonterminalsUsed.contains(symbol)) {
        ParseTreeNode childNode = buildTree(symbol);
        currentNode.children.add(childNode);
      } else {
        currentNode.children.add(ParseTreeNode(symbol));
      }
    }
    return currentNode;
  }

  ParseTreeNode rootNode = buildTree(nonterminalsUsed[0]);
  return rootNode;
}