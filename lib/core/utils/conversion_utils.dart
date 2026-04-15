/// Conversion helper methods.
abstract final class ConversionUtils {
  /// Converts temperature to celsius from [from] unit.
  static double toCelsius(double value, String from) {
    switch (from) {
      case 'F':
        return (value - 32) * 5 / 9;
      case 'K':
        return value - 273.15;
      default:
        return value;
    }
  }

  /// Converts celsius [value] into [to] unit.
  static double fromCelsius(double value, String to) {
    switch (to) {
      case 'F':
        return (value * 9 / 5) + 32;
      case 'K':
        return value + 273.15;
      default:
        return value;
    }
  }
}

