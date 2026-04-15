/// Calculator expression evaluation use case.
class CalculateExpression {
  /// Creates [CalculateExpression].
  const CalculateExpression();

  /// Evaluates a simple arithmetic expression with +,-,*,/ operators.
  double call(String expression) {
    try {
      final String sanitized = expression.replaceAll('×', '*').replaceAll('÷', '/').replaceAll(' ', '');
      if (sanitized.isEmpty) return 0;

      // Handle leading negative
      String processStr = sanitized;
      if (processStr.startsWith('-')) {
        processStr = '0' + processStr;
      }

      final RegExp tokenRegExp = RegExp(r'(\d*\.?\d+|[+\-*/])');
      final List<String> tokens = tokenRegExp.allMatches(processStr).map((RegExpMatch m) => m.group(0)!).toList();

      if (tokens.isEmpty) return 0;

      final List<String> stack = <String>[];
      int i = 0;
      while (i < tokens.length) {
        final String token = tokens[i];
        if (token == '*' || token == '/') {
          if (i + 1 >= tokens.length) return double.nan; // Incomplete expression
          final double lhs = double.parse(stack.removeLast());
          final double rhs = double.parse(tokens[i + 1]);
          if (token == '/' && rhs == 0) return double.nan; // Division by zero
          stack.add((token == '*') ? (lhs * rhs).toString() : (lhs / rhs).toString());
          i += 2;
        } else {
          stack.add(token);
          i += 1;
        }
      }

      if (stack.isEmpty) return 0;
      double result = double.parse(stack.first);
      for (int j = 1; j < stack.length; j += 2) {
        if (j + 1 >= stack.length) return double.nan; // Incomplete expression
        final String op = stack[j];
        final double value = double.parse(stack[j + 1]);
        if (op == '+') result += value;
        if (op == '-') result -= value;
      }
      return result;
    } catch (e) {
      return double.nan;
    }
  }
}
