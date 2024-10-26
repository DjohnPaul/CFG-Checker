import 'state.dart';
import 'grammar.dart';

class EarleyParser {
  final Grammar grammar;
  final String startSymbol;
  List<List<State>> chart = [];
  List<String> usedProductionRules = []; //
  List<String> nonterminalsUsed = [];
  List<String> productionUsed = [];

  EarleyParser(this.grammar, this.startSymbol);

  bool parse(String input) {

    chart = List<List<State>>.generate(input.length + 1, (_) => []);
    usedProductionRules = []; // Clear list before each parse

    // Add initial state
    chart[0].add(State(startSymbol, [startSymbol], 0, 0));

    // Process chart step by step
    for (int i = 0; i <= input.length; i++) {
      for (int j = 0; j < chart[i].length; j++) {
        State state = chart[i][j];
        if (!state.isComplete) {
          String? nextSymbol = state.nextSymbol;
          if (grammar.rules.containsKey(nextSymbol)) {
            _predict(state, i);
            if (grammar.isNullable(nextSymbol!)) {
              _completeNullable(state, i);
            }
          } else if (i < input.length && nextSymbol == input[i]) {
            _scan(state, i, input[i]);
          }
        } else {
          _complete(state, i);
        }
      }
    }

    // Check if start symbol has been parsed completely
    return chart[input.length].any((state) =>
    state.lhs == startSymbol && state.isComplete && state.origin == 0);
  }

  // Prediction: add states for non-terminal expansion
  void _predict(State state, int position) {
    String nonTerminal = state.nextSymbol!;
    for (List<String> production in grammar.getProductions(nonTerminal)) {
      State newState = State(nonTerminal, production, 0, position);
      if (!_stateExists(chart[position], newState)) {
        chart[position].add(newState);
      }
    }
  }

  // Scanning: match terminal symbols in the input
  void _scan(State state, int position, String terminal) {
    State newState = state.advance();
    if (!_stateExists(chart[position + 1], newState)) {
      chart[position + 1].add(newState);
    }
  }

  // Completion: move forward in rules that predicted this non-terminal
  void _complete(State state, int position) {
    List<State> newStates = [];

    for (State prevState in chart[state.origin]) {
      if (prevState.nextSymbol == state.lhs) {
        State newState = prevState.advance([state]); // Track child states
        if (!_stateExists(chart[position], newState)) {
          newStates.add(newState); // Collect new states
          usedProductionRules.add(
              '${prevState.lhs} -> ${prevState.rhs.join(' ')}'); // Track the rule
        }
      }
    }

    chart[position].addAll(newStates);
  }

  void _completeNullable(State state, int position) {
    State newState = state.advance();
    if (!_stateExists(chart[position], newState)) {
      chart[position].add(newState);
    }
  }

  bool _stateExists(List<State> states, State newState) {
    return states.any((state) =>
    state.lhs == newState.lhs &&
        state.rhs == newState.rhs &&
        state.dot == newState.dot &&
        state.origin == newState.origin);
  }

  void generateParseTree(String input) {
    State? finalState = chart[input.length].firstWhere(
            (state) =>
        state.lhs == startSymbol && state.isComplete && state.origin == 0,
        orElse: () => State('', [], 0, 0));

    if (finalState != null && finalState.lhs.isNotEmpty) {
      _printProductionRules(finalState);
    } else {
      print('No valid parse tree found.');
    }
  }

  void _printProductionRules(State state) {
    String rhsWithEpsilon = state.rhs.map((symbol) {
      return symbol == 'ɛ' ? 'ɛ' : symbol;
    }).join(' ');
    nonterminalsUsed.add(state.lhs);
    productionUsed.add(rhsWithEpsilon);

    for (var child in state.children) {
      _printProductionRules(child);
    }
  }
}