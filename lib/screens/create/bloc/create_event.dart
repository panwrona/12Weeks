
abstract class CreateEvent {}

class StartDateCreateEvent extends CreateEvent {
  DateTime date;

  StartDateCreateEvent(this.date);

}
class EndDateCreateEvent extends CreateEvent {
  DateTime date;

  EndDateCreateEvent(this.date);
}