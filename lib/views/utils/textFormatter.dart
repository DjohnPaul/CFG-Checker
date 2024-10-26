import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class TextSeparator {
  List<List<String>> separateText(String input) {
    List<List<String>> left = [[]];

    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (char == '|') {
        left.add([]);
      } else if (char != ' ') { // If you want to allow spaces then remove condition
        left[left.length - 1].add(char);
      }
    }
    return left;
  }
  List<String> separateTextDuplicate (String input){
    List<String> left = [];
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      left.add(char);
    }
    return left;
  }
  List<List<String>> convertTo2DList(List<String> inputList) {
    // Initialize an empty list to hold the 2D list
    List<List<String>> outputList = [];

    // Iterate through each string in the input list
    for (String item in inputList) {
      // Split the string by spaces and add the resulting list to outputList
      outputList.add(item.split(' '));
    }

    return outputList;
  }
}

