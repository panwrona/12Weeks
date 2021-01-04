
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGoalsScreen extends StatelessWidget {
  final nextPage = 2;

  PageController controller;

  AddGoalsScreen({@required this.controller}) : super();

  Widget _buttonWithNavigation() {
    return RaisedButton(
        child: Text('Przejdz dalej'),
        onPressed: () => {
          controller.animateToPage(nextPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _buttonWithNavigation()
          ]),
    );
  }
}