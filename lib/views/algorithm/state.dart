class State {
  final String lhs;
  final List<String> rhs;
  final int dot;
  final int origin;
  final List<State> children;

  State(this.lhs, this.rhs, this.dot, this.origin, [this.children = const []]);

  bool get isComplete => dot >= rhs.length;
  String? get nextSymbol => isComplete ? null : rhs[dot];

  State advance([List<State> newChildren = const []]) {
    return State(lhs, rhs, dot + 1, origin, [...children, ...newChildren]);
  }

  @override
  String toString() {
    var rhsWithDot = List<String>.from(rhs);
    rhsWithDot.insert(dot, '•');
    return '$lhs -> ${rhsWithDot.join(' ')} [$origin]';
  }
}