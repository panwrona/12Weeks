import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/goals/add_goals_bloc.dart';

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

  final nextPage = 2;
  PageController controller;
  final _goalEditingController = TextEditingController();
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
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildGoalEditText(this._bloc),
                  buildAddGoalButton(this._bloc)
                ],
              ),
            ),
            SizedBox(height: 20),
            buildGoalsList(this._bloc)
          ],
        ),
      ),
    );
  }

  Widget buildGoalEditText(AddGoalsBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.getGoal,
        builder: (context, snapshot) {
          return Container(
            width: 200,
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _goalEditingController,
              decoration: InputDecoration(
                labelText: 'Goal',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeGoal,
            ),
          );
        });

  }

  Widget buildAddGoalButton(AddGoalsBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.getGoal,
        builder: (context, snapshot) {
          return RaisedButton(
              child: Text('Dodaj cel'),
              onPressed:
              (!snapshot.hasData) ? null : () => {
                _goalEditingController.clear(),
                _addGoal(snapshot.data)
              });
        });
  }

  Widget buildGoalsList(AddGoalsBloc bloc) {
    return StreamBuilder<List<String>>(
        stream: bloc.getGoalsList,
        builder: (context, snapshot) {
          return (snapshot.data == null || snapshot.data.isEmpty) ? Text(
              'No items yet') :
          Flexible(
              child: ListView(
                  children: [
                    goalCard(snapshot.data, bloc),
                    buildNextButton()
                  ]
              )
          );
        }
    );
  }

  Widget buildNextButton() {
    return Center(
      child: RaisedButton(
        child: Text('Krok 3/3'),
        onPressed: () => {
          controller.animateToPage(nextPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut)
        }
      ),
    );
  }

  Widget goalCard(List<String> goals, AddGoalsBloc bloc) {
    return Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var text in goals)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '$text',
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => bloc.removeGoal(text),
                        // handle your image tap here
                        child: Icon(
                            Icons.remove_circle
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ));
  }

  _addGoal(String text) {
    this._bloc.addGoal(text);
  }
}
