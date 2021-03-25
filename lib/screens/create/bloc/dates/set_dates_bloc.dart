import 'package:flutter/foundation.dart';
import 'package:twelve_weeks/repostitory/project/project_repository.dart';

class SetDatesBloc extends ChangeNotifier {

  ProjectRepository _projectRepository;
  DateTime _startDate;
  DateTime _endDate;

  set projectRepository(ProjectRepository repository) {
    _projectRepository = repository;
    notifyListeners();
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
    _endDate = _startDate.add(Duration(days: 84));
    _projectRepository.setProjectDates(_startDate, _endDate);
    notifyListeners();
  }

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;
}