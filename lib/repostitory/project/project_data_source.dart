import 'package:hive/hive.dart';
import 'package:twelve_weeks/repostitory/project/model/db_project.dart';

class ProjectDataSource {
  static const String DB_PROJECT = "project";

  Box<DBProject> _box;

  ProjectDataSource(this._box);

  Future<DBProject> getProject() async {
    if (this.boxIsClosed) {
      return null;
    }
    return this._box.get(DB_PROJECT);
  }

  Future<void> saveProject(DBProject project) async {
    if (this.boxIsClosed) {
      return;
    }
    await _box.put(DB_PROJECT, project);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
}
