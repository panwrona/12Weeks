
abstract class AddGoalsEvent {}

class AddGoal extends AddGoalsEvent {
  String goal;

  AddGoal(this.goal);
}

class RemoveGoal extends AddGoalsEvent {
  String goal;

  RemoveGoal(this.goal);
}