part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class LoadServicesEvent extends HomeEvent {}

final class LoadRestaurantsEvent extends HomeEvent {}

final class ChangeBannerIndexEvent extends HomeEvent {
  final int index;
  ChangeBannerIndexEvent(this.index);
}
