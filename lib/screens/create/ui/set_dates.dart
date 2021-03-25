
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twelve_weeks/screens/create/bloc/dates/set_dates_bloc.dart';

class SetDatesScreen extends StatelessWidget {
  const SetDatesScreen({@required this.controller, Key key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return _SetDatesScreenState(controller: controller);
  }
}

class _SetDatesScreenState extends StatelessWidget {

  _SetDatesScreenState({@required this.controller}) : super();

  final int _nextPage = 1;
  final PageController controller;
  SetDatesBloc _bloc;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _bloc.startDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _bloc.startDate) {
      this._bloc.setStartDate(picked);
    }
  }

  bool _isStartDateAndEndDateChosen(SetDatesBloc state) {
    return state.startDate != null && state.endDate != null;
  }

  void _goToNextPage(DateTime dateTime) {
    controller.animateToPage(_nextPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = context.watch<SetDatesBloc>();

    return Scaffold(
      body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_bloc.startDate == null
                        ? 'Brak daty'
                        : _bloc.startDate.toString()),
                    ElevatedButton(
                        child: Text('Wybierz startowa date'),
                        onPressed: () => _selectStartDate(context)),
                    Text(_bloc.endDate == null
                        ? 'Brak daty'
                        : _bloc.endDate.toString()),
                    ElevatedButton(
                      child: Text('Przejdz dalej'),
                      onPressed: _isStartDateAndEndDateChosen(_bloc)
                          ? () => _goToNextPage(_bloc.startDate)
                          : null,
                    )
                  ],
                )
              ],
            ),
          ),
      );
  }
}
