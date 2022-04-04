import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AdditionalStyle on TextStyle {
  TextStyle withColor(Color color) {
    return merge(TextStyle(color: color));
  }

  TextStyle withFontSize(double size) {
    return merge(TextStyle(fontSize: size));
  }
}

extension DateFormatting on DateTime? {
  String toText() {
    if (this == null) {
      return '';
    }
    return DateFormat("yyyy-MM-dd").format(this!);
  }
}

extension StringFormatting on String {
  DateTime toDate({String? format}) {
    return DateFormat(format ?? "yyyy-MM-dd").parse(this);
  }

  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension ThemeOfContext on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;
}
