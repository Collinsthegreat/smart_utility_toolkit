import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utility_toolkit/features/bmi_calculator/domain/usecases/calculate_bmi.dart';

void main() {
  group('CalculateBmi', () {
    test('calculates correct metric BMI', () {
      const CalculateBmi calculate = CalculateBmi();
      final result = calculate(height: 180, weight: 75);
      
      // 75 / (1.8 * 1.8) = 75 / 3.24 = 23.15
      expect(result.value, closeTo(23.148, 0.01));
      expect(result.category, 'Normal');
    });

    test('calculates correct imperial BMI', () {
      const CalculateBmi calculate = CalculateBmi();
      // 5'10" = 70 inches, 165 lbs
      final result = calculate(height: 70, weight: 165, isImperial: true);
      
      // 703 * 165 / (70 * 70) = 115995 / 4900 = 23.67
      expect(result.value, closeTo(23.67, 0.01));
      expect(result.category, 'Normal');
    });

    test('handles negative/zero inputs', () {
      const CalculateBmi calculate = CalculateBmi();
      final result = calculate(height: 0, weight: 100);
      
      expect(result.value, 0);
      expect(result.category, 'Invalid');
    });
  });
}
