
abstract class SetDatesEvent {}

class StartDateCreateEvent extends SetDatesEvent {
  DateTime date;

  StartDateCreateEvent(this.date);

}
class EndDateCreateEvent extends SetDatesEvent {
  DateTime date;

  EndDateCreateEvent(this.date);
}