import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/create_event.dart';
import 'package:twelve_weeks/screens/create/bloc/create_project_bloc.dart';
import 'package:twelve_weeks/screens/create/bloc/create_state.dart';

class CreateScreenContainer extends StatelessWidget {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        CreateScreen(controller: _controller),
        AddGoalsScreen(controller: _controller),
        AddStrategiesScreen(controller: _controller)
      ],
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

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

class CreateScreen extends StatefulWidget {
  const CreateScreen({@required this.controller, Key key}) : super(key: key);

  final PageController controller;

  @override
  _CreateScreenState createState() =>
      _CreateScreenState(controller: controller);
}

class _CreateScreenState extends State<CreateScreen> {
  _CreateScreenState({@required this.controller}) : super();

  final int _nextPage = 1;
  PageController controller;
  DateTime _startDate;
  CreateProjectBloc _bloc;

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final userRepository = RepositoryProvider.of<ProjectRepository>(context);
      this._bloc = CreateProjectBloc(userRepository);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _startDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _startDate) {
      this._bloc.add(StartDateCreateEvent(picked));
    }
  }

  bool _isStartDateAndEndDateChosen(CreateState state) {
    return state.startDate != null && state.endDate != null;
  }

  void _goToNextPage() {
    controller.animateToPage(_nextPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateProjectBloc, CreateState>(
        cubit: this._bloc,
        builder: (context, state) {
          return SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.startDate == null
                        ? 'Brak daty'
                        : state.startDate.toString()),
                    RaisedButton(
                        child: Text('Wybierz startowa date'),
                        onPressed: () => _selectStartDate(context)),
                    Text(state.endDate == null
                        ? 'Brak daty'
                        : state.endDate.toString()),
                    RaisedButton(
                      child: Text('Przejdz dalej'),
                      onPressed: _isStartDateAndEndDateChosen(state)
                          ? () => _goToNextPage()
                          : null,
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
