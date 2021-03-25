import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twelve_weeks/screens/create/bloc/strategies/add_strategies_bloc.dart';

class AddStrategiesScreen extends StatefulWidget {
  final previousPage = 1;
  final PageController controller;

  AddStrategiesScreen({@required this.controller}) : super();

  @override
  State<StatefulWidget> createState() {
    return _AddStrategiesState();
  }
}

class _AddStrategiesState extends State<AddStrategiesScreen> {
  int _index;

  @override
  Widget build(BuildContext context) {
    var _bloc = context.watch<AddStrategiesBloc>();

    return Container(
      color: Colors.blue,
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [_listOfGoals(_bloc)]),
    );
  }

  Widget _listOfGoals(AddStrategiesBloc bloc) {
    return Flexible(
      child: Center(
        child: SizedBox(
          height: 200, // card height
          child: PageView.builder(
            itemCount: bloc.goalsList.length,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      bloc.goalsList[i],
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
