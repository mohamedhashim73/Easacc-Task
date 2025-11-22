import 'package:flutter/material.dart';

extension IntExtensions on int{
  String get withQuestions=> this == 1 || this > 10 ? "$this سؤال": "$this أسئلة";
  String get withMinutes=> this == 1 || this > 10 ? "$this دقيقة": "$this دقائق";
  Widget get vrSpace => SizedBox(height: toDouble());
  Widget get hrSpace => SizedBox(width: toDouble());
  String get twoDigits => "${toString().length == 2 ? this : "0$this"}";
  String get formatMinutesToArabic{
    try{
      if (this < 60) {
        return '$this ${this == 1 ? "دقيقة" : "دقائق"}';
      } else {
        final hours = (this / 60).floor();
        return '$hours ${hours == 1 ? "ساعة" : "ساعات"}';
      }
    }
    catch(e){
      return "$this دقيقة";
    }
  }
}