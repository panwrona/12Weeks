import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/goals/add_goals_bloc.dart';
import 'package:twelve_weeks/screens/create/bloc/goals/add_goals_event.dart';
import 'package:twelve_weeks/screens/create/bloc/goals/add_goals_state.dart';

class AddGoalsScreen extends StatefulWidget {
  const AddGoalsScreen({@required this.controller, Key key}) : super(key: key);

  final PageController controller;

  @override
  State<StatefulWidget> createState() {
    return _AddGoalsState(controller: controller);
  }
}

class _AddGoalsState extends State<AddGoalsScreen> {
  _AddGoalsState({@required this.controller}) : super();

  final addGoalController = TextEditingController();
  final nextPage = 2;
  PageController controller;
  AddGoalsBloc _bloc;

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final userRepository = RepositoryProvider.of<ProjectRepository>(context);
      this._bloc = AddGoalsBloc(userRepository);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    addGoalController.dispose();
    _bloc.close();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AddGoalsBloc, AddGoalsState>(
            cubit: this._bloc,
            builder: (context, state) {
              return SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildGoalEditText(this._bloc),
                    buildButton(this._bloc)
                  ],
                ),
              );
            }));
  }

  Widget buildGoalEditText(AddGoalsBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.getGoal,
        builder: (context, snapshot) {
          return Container(
            width: 200,
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeGoal,
            ),
          );
        }
    );
  }

  Widget buildButton(AddGoalsBloc bloc) {
    return StreamBuilder <String>(
        stream: bloc.getGoal,
        builder: (context, snapshot) {
          return RaisedButton(
              child: Text('Dodaj cel'),
              onPressed:
              (!snapshot.hasData)
                  ? null
                  : () => { _addGoal(snapshot.data) }
          );
        });
  }

  _addGoal(String text) {
    this._bloc.add(AddGoal(text));
  }
}
