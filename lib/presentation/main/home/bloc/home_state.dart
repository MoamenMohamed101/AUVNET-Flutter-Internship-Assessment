part of 'home_bloc.dart';

// @immutable
// sealed class HomeState {}
//
// final class HomeInitial extends HomeState {}
//
// final class ServicesLoading extends HomeState {}
//
// final class ServicesLoaded extends HomeState {
//   final List<ServiceModel> services;
//
//   ServicesLoaded(this.services);
// }
//
// final class ServicesError extends HomeState {
//   final String message;
//
//   ServicesError(this.message);
// }
//
// final class RestaurantsLoading extends HomeState {}
//
// final class RestaurantsLoaded extends HomeState {
//   final List<RestaurantsModel> restaurants;
//
//   RestaurantsLoaded(this.restaurants);
// }
//
// final class RestaurantsError extends HomeState {
//   final String message;
//
//   RestaurantsError(this.message);
// }

@immutable
class HomeState {
  final List<ServiceModel> services;
  final List<RestaurantsModel> restaurants;
  final bool isLoadingServices;
  final bool isLoadingRestaurants;
  final String? servicesError;
  final String? restaurantsError;
  final int currentBannerIndex;

  const HomeState({
    this.services = const [],
    this.restaurants = const [],
    this.isLoadingServices = false,
    this.isLoadingRestaurants = false,
    this.servicesError,
    this.restaurantsError,
    this.currentBannerIndex = 0,
  });

  HomeState copyWith({
    List<ServiceModel>? services,
    List<RestaurantsModel>? restaurants,
    bool? isLoadingServices,
    bool? isLoadingRestaurants,
    String? servicesError,
    String? restaurantsError,
    int? currentBannerIndex,
  }) {
    return HomeState(
      services: services ?? this.services,
      restaurants: restaurants ?? this.restaurants,
      isLoadingServices: isLoadingServices ?? this.isLoadingServices,
      isLoadingRestaurants: isLoadingRestaurants ?? this.isLoadingRestaurants,
      servicesError: servicesError,
      restaurantsError: restaurantsError,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
    );
  }
}
