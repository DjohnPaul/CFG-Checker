import '/views/tree/tree.dart';
import 'package:flutter/material.dart';

class ResultTreePage extends StatelessWidget {
  final List<String> nonTerminalsUsed;
  final List<List<String>> productionsUsed;

  ResultTreePage({required this.nonTerminalsUsed, required this.productionsUsed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Derivation Tree",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ParseTree(nonTerminalsUsed, productionsUsed),
          ),
        ),
      ),
    );
  }
}