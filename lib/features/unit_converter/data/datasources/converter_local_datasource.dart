import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/conversion_model.dart';

/// Local source for conversion history.
class ConverterLocalDataSource {
  /// Creates [ConverterLocalDataSource].
  ConverterLocalDataSource(this._box);

  final Box<dynamic> _box;

  /// Saves conversion and trims to last 10.
  Future<void> saveConversion(ConversionModel model) async {
    final List<dynamic> data = _box.get(AppConstants.converterHistoryBox, defaultValue: <dynamic>[]) as List<dynamic>;
    data.insert(0, model.toJson());
    if (data.length > 10) {
      data.removeRange(10, data.length);
    }
    await _box.put(AppConstants.converterHistoryBox, data);
  }

  /// Returns conversion history.
  List<ConversionModel> getHistory() {
    final List<dynamic> data = _box.get(AppConstants.converterHistoryBox, defaultValue: <dynamic>[]) as List<dynamic>;
    return data.map((dynamic e) => ConversionModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }
}
