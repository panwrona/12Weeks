import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/strategies/add_strategies_bloc.dart';

class AddStrategiesScreen extends StatefulWidget {
  final previousPage = 1;
  PageController controller;

  AddStrategiesScreen({@required this.controller}) : super();

  @override
  State<StatefulWidget> createState() {
    return _AddStrategiesState();
  }
}

class _AddStrategiesState extends State<AddStrategiesScreen> {
  AddStrategiesBloc _bloc;
  int _index;

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final userRepository = RepositoryProvider.of<ProjectRepository>(context);
      this._bloc = AddStrategiesBloc(userRepository);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
          alignment: AlignmentDirectional.center, children: [_listOfGoals()]),
    );

  }

  Widget _listOfGoals() {
    return StreamBuilder<List<String>>(
        stream: _bloc.getGoalsList,
        builder: (context, snapshot) {
          return Flexible(
            child: Center(
              child: SizedBox(
                height: 200, // card height
                child: PageView.builder(
                  itemCount: snapshot.data.length,
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
                            snapshot.data[i],
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
        });
  }
}
