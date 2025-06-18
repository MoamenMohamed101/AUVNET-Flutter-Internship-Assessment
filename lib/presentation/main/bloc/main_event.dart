part of 'main_bloc.dart';

abstract class MainEvent {}

class ChangePageEvent extends MainEvent {
  final int index;
  ChangePageEvent(this.index);
}