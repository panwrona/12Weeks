
import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';

class AddStrategiesBloc {

  BehaviorSubject<List<String>> _goalsListStream;

  final ProjectRepository _projectRepository;

  AddStrategiesBloc(this._projectRepository) {
    _goalsListStream = BehaviorSubject<List<String>>.seeded(_projectRepository.getGoalsList());
  }

  Stream<List<String>> get getGoalsList => _goalsListStream.stream;

}