import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twelve_weeks/screens/create/ui/set_dates.dart';

import 'add_goals.dart';
import 'add_strategies.dart';

class CreateScreenContainer extends StatelessWidget {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        SetDatesScreen(controller: _controller),
        AddGoalsScreen(controller: _controller),
        AddStrategiesScreen(controller: _controller)
      ],
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}