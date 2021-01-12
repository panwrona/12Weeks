import 'package:flutter_test/flutter_test.dart';
import 'package:twelve_weeks/screens/create/bloc/goals/add_goals_bloc.dart';

void main() {
  test('Stream should pass error when goal is null', () {
    final bloc = AddGoalsBloc(null);

    bloc.getGoal.listen((event) {

    }, onError: (error) {
      expect(error, isNotNull);
    });

    bloc.changeGoal(null);
  });

  test('Stream should pass goal when is not null', () {
    final bloc = AddGoalsBloc(null);
    final dummyGoal = 'dummyGoal';

    bloc.getGoal.listen((event) {
     expect(event, dummyGoal);
    });

    bloc.changeGoal(dummyGoal);
  });
}
