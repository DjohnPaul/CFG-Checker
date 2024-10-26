class Grammar {
  final Map<String, List<List<String>>> rules;
  final Set<String> nullableNonTerminals = {};

  Grammar(this.rules) {
    _computeNullableNonTerminals();
  }

  List<List<String>> getProductions(String nonTerminal) {
    return rules[nonTerminal] ?? [];
  }

  void _computeNullableNonTerminals() {
    bool changed = true;
    while (changed) {
      changed = false;
      rules.forEach((nonTerminal, productions) {
        if (!nullableNonTerminals.contains(nonTerminal)) {
          for (var production in productions) {
            if (production.contains('ɛ') ||
                production
                    .every((symbol) => nullableNonTerminals.contains(symbol))) {
              nullableNonTerminals.add(nonTerminal);
              changed = true;
              break;
            }
          }
        }
      });
    }
  }

  bool isNullable(String nonTerminal) {
    return nullableNonTerminals.contains(nonTerminal);
  }
}