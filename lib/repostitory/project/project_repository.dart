import 'package:flutter/cupertino.dart';
import 'package:twelve_weeks/repostitory/project/model/project.dart';
import 'package:twelve_weeks/repostitory/project/project_data_source.dart';

class ProjectRepository {
  ProjectDataSource dataSource;
  List<String> _goals = List();
  DateTime _startDate;
  DateTime _endDate;

  ProjectRepository({@required this.dataSource});

  Future<Project> getProject() async {
    var dbProject = await dataSource.getProject();
    if (dbProject == null) {
      return null;
    }
    return new Project(dbProject.startDate, dbProject.endDate);
  }

  Future<void> saveProject(Project project) {}

  setProjectDates(DateTime startDate, DateTime endDate) {
    _startDate = startDate;
    _endDate = endDate;
  }

  bool hasGoal(String goal) {
    return _goals.contains(goal);
  }

  addGoal(String goal) {
    _goals.add(goal);
  }

  removeGoal(String goal) {
    _goals.remove(goal);
  }

  getGoalsList() {
    return _goals;
  }
}
