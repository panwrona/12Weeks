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
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: addGoalController,
                      ),
                    ),
                    RaisedButton(
                        child: Text('Dodaj cel'),
                        onPressed: _isTextFieldEmpty() ? null : _addGoal())
                  ],
                ),
              );
            }));
  }

  bool _isTextFieldEmpty() {
    return addGoalController.text.isNotEmpty;
  }

  _addGoal() {
    this._bloc.add(AddGoal(addGoalController.text));
  }
}
