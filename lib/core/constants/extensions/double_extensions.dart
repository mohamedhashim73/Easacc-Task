import 'package:flutter/material.dart';

extension DoubleExtensions on double{
  String get percentageTxt=> this == 100 ? "مكتمل" : "قيد التقدم";
  String get withCurrency=> "$this ج.م";
  String get withMinutes=> this == 1 || this > 10 ? "${toInt()} دقيقة": "${toInt()} دقائق";
  Widget get vrSpace => SizedBox(height: toDouble());
  Widget get hrSpace => SizedBox(width: toDouble());
}
