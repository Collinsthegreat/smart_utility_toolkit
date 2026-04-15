import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:smart_utility_toolkit/core/constants/app_constants.dart';
import 'package:smart_utility_toolkit/features/unit_converter/data/datasources/converter_local_datasource.dart';
import 'package:smart_utility_toolkit/features/unit_converter/data/models/conversion_model.dart';
import 'package:smart_utility_toolkit/features/unit_converter/data/repositories/converter_repository_impl.dart';

void main() {
  late Directory tempDir;
  late Box<dynamic> box;
  late ConverterRepositoryImpl repository;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('smart_utility_toolkit_test');
    Hive.init(tempDir.path);
    box = await Hive.openBox<dynamic>(AppConstants.converterHistoryBox);
    repository = ConverterRepositoryImpl(ConverterLocalDataSource(box));
  });

  tearDownAll(() async {
    await box.close();
    await tempDir.delete(recursive: true);
  });

  test('converts kilometers to meters', () {
    expect(repository.convert(category: 'Length', from: 'km', to: 'm', value: 1), 1000);
  });

  test('converts currency USD to EUR', () {
    expect(repository.convert(category: 'Currency', from: 'USD', to: 'EUR', value: 100).round(), 92);
  });

  test('saves and retrieves history entries', () async {
    final ConversionModel conversion = ConversionModel(
      category: 'Length',
      fromUnit: 'm',
      toUnit: 'km',
      input: 1000,
      output: 1,
      timestamp: DateTime.now(),
    );

    expect(repository.getHistory(), isEmpty);
    await repository.saveConversion(conversion);
    expect(repository.getHistory(), isNotEmpty);
    expect(repository.getHistory().first.input, 1000);
  });
}
