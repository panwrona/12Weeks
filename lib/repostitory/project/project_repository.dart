
import 'package:flutter/cupertino.dart';
import 'package:twelve_weeks/repostitory/project/model/db_project.dart';
import 'package:twelve_weeks/repostitory/project/model/project.dart';
import 'package:twelve_weeks/repostitory/project/project_data_source.dart';

class ProjectRepository {
  ProjectDataSource dataSource;

  ProjectRepository({
    @required this.dataSource
  });

  Future<Project> getProject() async {
    var dbProject = await dataSource.getProject();
    if(dbProject == null) {
      return null;
    }
    return new Project(dbProject.startDate, dbProject.endDate);
  }

  Future<void> saveProject(Project project) {

  }

}