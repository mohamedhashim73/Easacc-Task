import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

extension BuildContextExtensions on BuildContext {
  BorderRadius get max => BorderRadius.circular(22);
  BorderRadius get main => BorderRadius.circular(14);
  BorderRadius get min => BorderRadius.circular(10);
  EdgeInsets get listViewPadding => const EdgeInsets.only(bottom: 22);
  EdgeInsets get scaffoldPadding => EdgeInsets.fromLTRB(14, 14, 14, 0);
  EdgeInsets get cardPadding => EdgeInsets.all(14);
  BoxBorder get basic => BoxBorder.all(color: AppColors.kBorder,width: 1);
  double concatenatePaddingOnBottom (double val)=> val + bottomPadding;
  double concatenatePaddingOnTop (double val)=> val + topPadding;
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  double get bottomInsets => MediaQuery.of(this).viewInsets.bottom;
  double get screenHeight => MediaQuery.of(this).size.height;
  Orientation get orientation => MediaQuery.of(this).orientation;
}

extension RoutingExtensions on BuildContext {
  dynamic get pop => Navigator.pop(this);
  dynamic push (Widget widget)=> Navigator.push(this, MaterialPageRoute(builder: (context)=> widget));
  dynamic pushAndRemovePreviousRoutes (Widget widget)=> Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (context)=> widget),(_)=> false);
  dynamic pushNamed (String routeKey)=> Navigator.pushNamed(this, routeKey);
  dynamic pushNamedAndRemovePreviousRoutes (String routeKey)=> Navigator.pushNamedAndRemoveUntil(this, routeKey,(_)=> false);
}

