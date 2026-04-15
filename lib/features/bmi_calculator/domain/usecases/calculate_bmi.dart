import '../entities/bmi_result_entity.dart';

/// BMI calculator use case.
class CalculateBmi {
  /// Creates [CalculateBmi].
  const CalculateBmi();
  BmiResultEntity call({required double height, required double weight, bool isImperial = false}) {
    if (height <= 0 || weight <= 0) return const BmiResultEntity(value: 0, category: 'Invalid', tip: 'Please enter valid positive numbers.');
    double bmi;
    if (isImperial) {
      bmi = 703 * weight / (height * height);
    } else {
      final double meters = height / 100;
      bmi = weight / (meters * meters);
    }
    if (bmi < 18.5) return BmiResultEntity(value: bmi, category: 'Underweight', tip: 'Increase nutrient-dense calories.');
    if (bmi < 25) return BmiResultEntity(value: bmi, category: 'Normal', tip: 'Maintain your healthy habits.');
    if (bmi < 30) return BmiResultEntity(value: bmi, category: 'Overweight', tip: 'Balance meals and activity.');
    return BmiResultEntity(value: bmi, category: 'Obese', tip: 'Consult a health professional.');
  }
}
