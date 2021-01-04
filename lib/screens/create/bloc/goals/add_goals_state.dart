
abstract class AddGoalsState {}

class Loading extends AddGoalsState {}
class AlreadyOnTheList extends AddGoalsState {}
class UpdatedList extends AddGoalsState {

  List<String> goals;

  UpdatedList(this.goals);
}
