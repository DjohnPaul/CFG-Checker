import 'package:flutter/material.dart';
import 'tree_node.dart';

class ParseTreePainter extends CustomPainter {
  final ParseTreeNode rootNode;
  final double nodeRadius = 15.0;
  final double horizontalSpacing = 20.0;
  final double verticalSpacing = 100.0;

  ParseTreePainter(this.rootNode);

  @override
  void paint(Canvas canvas, Size size) {

    double treeWidth = _calculateSubtreeWidth(rootNode);

    _drawNode(canvas, rootNode, Offset(size.width / 2, 50), treeWidth / 2);
  }

  void _drawNode(Canvas canvas, ParseTreeNode node, Offset position, double availableWidth) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawCircle(position, nodeRadius, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: node.value,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: 40);
    final offsetText = Offset(
        position.dx - textPainter.width / 2, position.dy - textPainter.height / 2);
    textPainter.paint(canvas, offsetText);

    if (node.children.isNotEmpty) {
      final childOffsetY = position.dy + verticalSpacing;

      double totalChildWidth = _calculateSubtreeWidth(node);
      double childOffsetX = position.dx - totalChildWidth / 2;

      for (var child in node.children) {
        double childWidth = _calculateSubtreeWidth(child);
        final childPosition = Offset(childOffsetX + childWidth / 2, childOffsetY);

        canvas.drawLine(position, childPosition, paint);

        _drawNode(canvas, child, childPosition, childWidth);
        childOffsetX += childWidth + horizontalSpacing;
      }
    }
  }

  double _calculateSubtreeWidth(ParseTreeNode node) {
    if (node.children.isEmpty) {
      return nodeRadius * 2 + horizontalSpacing;
    }

    double totalWidth = 0.0;
    for (var child in node.children) {
      totalWidth += _calculateSubtreeWidth(child);
    }

    return totalWidth + (node.children.length - 1) * horizontalSpacing;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
