part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class LoadServicesEvent extends HomeEvent {}

final class LoadRestaurantsEvent extends HomeEvent {}