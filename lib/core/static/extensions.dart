import 'package:dio/dio.dart';
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
  DateTime? toDate({String? format}) {
    try {
      final date = DateFormat(format ?? "yyyy-MM-dd").parse(this);
      return date;
    } catch (e) {
      return null;
    }
  }

  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension ThemeOfContext on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;
}

extension DynamicHeader on Dio {
  Dio withToken() {
    return this..options.headers.addAll({'token': true});
  }
}
