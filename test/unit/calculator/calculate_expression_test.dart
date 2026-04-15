import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utility_toolkit/features/calculator/domain/usecases/calculate_expression.dart';

void main() {
  group('CalculateExpression', () {
    test('evaluates simple addition', () {
      const CalculateExpression calculator = CalculateExpression();
      expect(calculator.call('2+2'), 4);
    });

    test('respects operator precedence', () {
      const CalculateExpression calculator = CalculateExpression();
      expect(calculator.call('2+3*4'), 14);
      expect(calculator.call('10/2-3'), 2);
    });

    test('handles decimal values and spaces', () {
      const CalculateExpression calculator = CalculateExpression();
      expect(calculator.call(' 3.5 + 2.5 '), 6);
      expect(calculator.call('4*2.5'), 10);
    });

    test('handles negative numbers', () {
      const CalculateExpression calculator = CalculateExpression();
      expect(calculator.call('-5+3'), -2);
      expect(calculator.call('-5-3'), -8);
    });

    test('returns NaN for division by zero', () {
      const CalculateExpression calculator = CalculateExpression();
      expect(calculator.call('5/0'), isNaN);
    });

    test('returns NaN for incomplete expressions', () {
      const CalculateExpression calculator = CalculateExpression();
      expect(calculator.call('5+'), isNaN);
      expect(calculator.call('5*'), isNaN);
    });
  });
}
