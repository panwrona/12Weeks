
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/dates/set_dates_bloc.dart';
import 'package:twelve_weeks/screens/create/bloc/dates/set_dates_event.dart';
import 'package:twelve_weeks/screens/create/bloc/dates/set_dates_state.dart';

class SetDatesScreen extends StatefulWidget {
  const SetDatesScreen({@required this.controller, Key key}) : super(key: key);

  final PageController controller;

  @override
  _SetDatesScreenState createState() =>
      _SetDatesScreenState(controller: controller);
}

class _SetDatesScreenState extends State<SetDatesScreen> {
  _SetDatesScreenState({@required this.controller}) : super();

  final int _nextPage = 1;
  PageController controller;
  DateTime _startDate;
  SetDatesBloc _bloc;

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final userRepository = RepositoryProvider.of<ProjectRepository>(context);
      this._bloc = SetDatesBloc(userRepository);
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

  bool _isStartDateAndEndDateChosen(SetDatesState state) {
    return state.startDate != null && state.endDate != null;
  }

  void _goToNextPage(DateTime dateTime) {
    controller.animateToPage(_nextPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SetDatesBloc, SetDatesState>(
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
                          ? () => _goToNextPage(state.startDate)
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
