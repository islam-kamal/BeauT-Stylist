import 'package:butyprovider/helpers/network-mappers.dart';

abstract class AppState {
  get model => null;
}

class NameError extends AppState {}

class PasswordError extends AppState {}

class EmailError extends AppState {}

class MobileError extends AppState {}

class AddressError extends AppState {}

class NumberError extends AppState {}

class Done extends AppState {
  Mappable model;

  Done(this.model);

  @override
  String toString() => 'Done';
}

class Start extends AppState {
  Mappable model;

  Start(this.model);

  @override
  String toString() => 'Start';
}

class Loading extends AppState {
  Mappable model;

  Loading(this.model);

  @override
  String toString() => 'Loading';
}

class ErrorLoading extends AppState {
  Mappable model;

  ErrorLoading(this.model);

  @override
  String toString() => 'Error';
}

class DeleteState extends AppState {
  Mappable model;

  DeleteState(this.model);

  @override
  String toString() => 'Delete';
}

class SendState extends AppState {
  Mappable model;

  SendState(this.model);

  @override
  String toString() => 'Delete';
}
