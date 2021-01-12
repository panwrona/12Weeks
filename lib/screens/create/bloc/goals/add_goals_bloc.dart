import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';

class AddGoalsBloc {
  final _goalStream = StreamController<String>.broadcast();
  BehaviorSubject<List<String>> _goalsListStream;

  final ProjectRepository _projectRepository;

  AddGoalsBloc(this._projectRepository) {
    _goalsListStream = BehaviorSubject<List<String>>.seeded(_projectRepository.getGoalsList());
  }

  Function(String) get changeGoal => _goalStream.sink.add;

  Stream<String> get getGoal => _goalStream.stream.transform(_goalValidator);

  Stream<List<String>> get getGoalsList => _goalsListStream.stream;

  final _goalValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (goal,sink) {
        if(goal.isNotEmpty){
          sink.add(goal);
        }
        else{
          sink.addError('Goal is empty!');
        }
      }
  );

  addGoal(String goal) {
    if(_projectRepository.hasGoal(goal)) {
      _goalsListStream.sink.addError('Goal is already on the list!');
    } else {
      _projectRepository.addGoal(goal);
      _goalsListStream.sink.add(_projectRepository.getGoalsList());
    }
  }

  removeGoal(String goal) {
    _projectRepository.removeGoal(goal);
    _goalsListStream.sink.add(_projectRepository.getGoalsList());
  }

  dispose() {
    _goalsListStream.close();
    _goalStream.close();
  }

}