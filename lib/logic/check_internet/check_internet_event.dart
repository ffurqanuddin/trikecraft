// Events
abstract class CheckInternetConnectionEvent {}
class CheckInternetConnectionStatusEvent extends CheckInternetConnectionEvent {}
class InternetConnectionChangedEvent extends CheckInternetConnectionEvent {
  final bool isConnected;
  InternetConnectionChangedEvent(this.isConnected);
}