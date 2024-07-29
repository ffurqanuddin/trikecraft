// States
abstract class CheckInternetConnectionState {}
class CheckInternetConnectionInitial extends CheckInternetConnectionState {}
class InternetConnectedState extends CheckInternetConnectionState {}
class NoInternetConnectionState extends CheckInternetConnectionState {}