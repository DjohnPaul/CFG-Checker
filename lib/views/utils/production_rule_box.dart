import 'textFormatter.dart';
import 'package:flutter/material.dart';

class ProductionRuleBox extends StatelessWidget {

  final TextEditingController leftController;
  final TextEditingController rightController;
  final VoidCallback? onRemove;
  final bool readOnlyLeft;

  ProductionRuleBox({
    required this.leftController,
    required this.rightController,
    required this.onRemove,
    this.readOnlyLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 40,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              readOnly: readOnlyLeft,
              controller: leftController,
              inputFormatters: [UpperCaseTextFormatter()],//Inputs are automatically uppercased
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                counterText: '',
              ),
            ),
          ),
          Icon(Icons.arrow_right_alt_outlined),
          Expanded(child: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: rightController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
            ),
          )),
          if (onRemove != null)
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: onRemove,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
