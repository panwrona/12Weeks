

import 'package:flutter/cupertino.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';

class AddStrategiesBloc extends ChangeNotifier {

  ProjectRepository _projectRepository;

  set projectRepository(ProjectRepository repository) {
    _projectRepository = repository;
    notifyListeners();
  }

  List<String> get goalsList => _projectRepository.getGoalsList();


}