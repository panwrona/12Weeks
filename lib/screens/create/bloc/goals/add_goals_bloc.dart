
import 'package:flutter/cupertino.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';

class AddGoalsBloc extends ChangeNotifier {

  ProjectRepository _projectRepository;

  set projectRepository(ProjectRepository repository) {
    _projectRepository = repository;
    notifyListeners();
  }

  GoalValidation _goalValidation = GoalValidation(null, null);
  GoalsList _goalsList = GoalsList([], null);

  validateGoal(String goal) {
    if(goal.isNotEmpty) {
      _goalValidation = GoalValidation(goal, null);
    } else {
      _goalValidation = GoalValidation(null, 'Goal is empty!');
    }
    notifyListeners();
  }
  
  GoalValidation get goalValidation => _goalValidation;

  GoalsList get goalsList => _goalsList;

  addGoal(String goal) {
    if(_projectRepository.hasGoal(goal)) {
      _goalsList = GoalsList(_projectRepository.getGoalsList(), 'Goal is already on the list!');
    } else {
      _projectRepository.addGoal(goal);
      _goalsList = GoalsList(_projectRepository.getGoalsList(), null);
    }
    notifyListeners();
  }

  removeGoal(String goal) {
    _projectRepository.removeGoal(goal);
    notifyListeners();
  }

}

class GoalValidation {
  final String goal;
  final String error;

  GoalValidation(this.goal, this.error);
}

class GoalsList {
  final List<String> goals;
  final String error;
  
  GoalsList(this.goals, this.error);
}