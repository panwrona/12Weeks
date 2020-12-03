import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/create_event.dart';
import 'package:twelve_weeks/screens/create/bloc/create_project_bloc.dart';
import 'package:twelve_weeks/screens/create/bloc/create_state.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DateTime _startDate;
  DateTime _endDate;
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

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _endDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _endDate) {
      this._bloc.add(EndDateCreateEvent(picked));
    }
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
                  Text(state.startDate.toString() ?? 'Brak daty'),
                  RaisedButton(
                      child: Text('Wybierz startowa date'),
                      onPressed: () => _selectStartDate(context))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.endDate.toString() ?? 'Brak daty'),
                  RaisedButton(
                      child: Text('Wybierz startowa date'),
                      onPressed: () => _selectEndDate(context))
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
