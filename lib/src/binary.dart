import 'package:string_converter/util/binary/utf8.dart';

class Binary {
  /**
   * Get the **UTF8** value from the given Binary **[text]**.
   *
   * Example:
   *
   * ```dart
   * UTF8.toBinary("1010100 1100101 1110011 1110100");
   * // Test
   * ```
   */
  static String toUTF8(String text) => UTF8(text).value;
}
