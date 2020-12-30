import 'package:flutter/material.dart';

BoxDecoration createProjectGradient() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.red[300], Colors.red]));
}

BoxDecoration addGoalsGradient() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue[300], Colors.blue]));
}