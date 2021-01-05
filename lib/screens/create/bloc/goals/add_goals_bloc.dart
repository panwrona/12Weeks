
import 'package:bloc/bloc.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';
import 'add_goals_state.dart';

import 'add_goals_event.dart';

class AddGoalsBloc extends Bloc<AddGoalsEvent, AddGoalsState> {

  final ProjectRepository _projectRepository;

  AddGoalsBloc(this._projectRepository) : super(Loading());

  @override
  Stream<AddGoalsState> mapEventToState(AddGoalsEvent event) async* {
    if(event is AddGoal) {
      if(_projectRepository.hasGoal(event.goal)) {
        yield AlreadyOnTheList();
      } else {
        _projectRepository.addGoal(event.goal);
        yield UpdatedList(_projectRepository.goals);
      }
    } else if (event is RemoveGoal) {
      _projectRepository.removeGoal(event.goal);
      yield UpdatedList(_projectRepository.goals);
    }
  }

}