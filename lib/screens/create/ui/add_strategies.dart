
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStrategiesScreen extends StatelessWidget {
  final previousPage = 1;

  PageController controller;

  AddStrategiesScreen({@required this.controller}) : super();

  Widget _buttonWithNavigation() {
    return RaisedButton(
        child: Text('Wroc'),
        onPressed: () => {
          controller.animateToPage(previousPage,  duration: Duration(milliseconds: 300), curve: Curves.easeInOut)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _buttonWithNavigation()
          ]),
    );
  }
}