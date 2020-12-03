
import 'package:bloc/bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';

import 'create_event.dart';
import 'create_state.dart';

class CreateProjectBloc extends Bloc<CreateEvent, CreateState> {

  final ProjectRepository _projectRepository;
  DateTime _startDate;
  DateTime _endDate;

  CreateProjectBloc(this._projectRepository) : super(CreateState());

  @override
  Stream<CreateState> mapEventToState(CreateEvent event) async* {
    if(event is StartDateCreateEvent) {
      _startDate = event.date;
    } else if (event is EndDateCreateEvent) {
      _endDate = event.date;
    }
    yield CreateState(startDate: _startDate, endDate: _endDate);
  }

}