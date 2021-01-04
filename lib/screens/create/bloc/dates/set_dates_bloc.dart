
import 'package:bloc/bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'package:twelve_weeks/screens/create/bloc/dates/set_dates_event.dart';

import 'set_dates_state.dart';

class SetDatesBloc extends Bloc<SetDatesEvent, SetDatesState> {

  final ProjectRepository _projectRepository;
  DateTime _startDate;
  DateTime _endDate;

  SetDatesBloc(this._projectRepository) : super(SetDatesState());

  @override
  Stream<SetDatesState> mapEventToState(SetDatesEvent event) async* {
    if(event is StartDateCreateEvent) {
      _startDate = event.date;
      _endDate = event.date.add(Duration(days: 84));
      _projectRepository.setProjectDates(_startDate, _endDate);
    }
    yield SetDatesState(startDate: _startDate, endDate: _endDate);
  }

}