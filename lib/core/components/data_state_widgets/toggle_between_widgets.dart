import 'package:flutter/material.dart';

class ToggleBetweenWidgets extends StatelessWidget {
  final bool showFirst;
  final Widget first;
  final Widget second;
  const ToggleBetweenWidgets({super.key, required this.showFirst, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return showFirst ? first : second;
  }
}
