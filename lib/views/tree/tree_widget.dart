import 'package:flutter/material.dart';
import 'tree_node.dart';
import 'tree_painter.dart';

class ParseTreeWidget extends StatelessWidget {
  final ParseTreeNode rootNode;

  ParseTreeWidget({required this.rootNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1500,
      height: 1000,
      child: CustomPaint(
        painter: ParseTreePainter(rootNode),
      ),
    );
  }
}
