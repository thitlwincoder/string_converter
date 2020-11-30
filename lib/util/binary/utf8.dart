import 'dart:convert';

class UTF8 {
  String text;
  bool singleByte;

  UTF8(this.text, {bool singleByte = true})
      : assert(text.isNotEmpty || text.length > 0),
        singleByte = singleByte;

  String get value => _value();

  String _value() {
    if (!RegExp(r"^[0-1 ]+").hasMatch(text)) {
      throw FormatException("Binary input required.");
    }

    text = text.replaceAll(RegExp(r"\s+"), ' ');
    text = text.replaceAll(RegExp(r"^\s+"), '');
    text = text.replaceAll(RegExp(r"\s+$"), '');

    List chars = [];

    if (text.indexOf(' ') > 0) {
      /// text values are separated by space
      var bytes = text.split(' ');

      for (int i = 0; i < bytes.length; i++) {
        chars.add(String.fromCharCode(int.parse(bytes[i], radix: 2)));
      }
    } else {
      /// text values are one large blob of binary bits
      if (text.length < 8) {
        while (text.length < 8) {
          text = "0" + text;
        }
      }

      if (text.length % 8 != 0) {
        throw FormatException(
            "Can't convert. Input binary doesn't split into groups of 8 bits evenly.");
      }

      for (int i = 0; i < text.length; i += 8) {
        chars.add(
            String.fromCharCode(int.parse(text.substring(i, i + 8), radix: 2)));
      }
    }

    text = chars.join("");

    if (singleByte) {
      text = utf8.decode(text.codeUnits);
    }

    return text;
  }
}
