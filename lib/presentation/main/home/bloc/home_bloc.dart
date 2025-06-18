import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/domain/models/service_model.dart';
import 'package:nawel/domain/usecase/get_restaurants_usecase.dart';
import 'package:nawel/domain/usecase/get_services_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final GetServicesUseCase getServicesUseCase;
//
//   final GetRestaurantsUseCase getRestaurantsUseCase;
//
//   HomeBloc(
//     this.getServicesUseCase,
//     this.getRestaurantsUseCase
//   ) : super(HomeInitial()) {
//     on<LoadServicesEvent>((event, emit) async {
//       emit(ServicesLoading());
//       try {
//         final services = await getServicesUseCase();
//         emit(ServicesLoaded(services));
//       } catch (e) {
//         emit(ServicesError(e.toString()));
//       }
//     });
//     on<LoadRestaurantsEvent>((event, emit) async {
//       emit(RestaurantsLoading());
//       try {
//         final restaurants = await getRestaurantsUseCase();
//         emit(RestaurantsLoaded(restaurants));
//       } catch (e) {
//         emit(RestaurantsError(e.toString()));
//       }
//     });
//   }
// }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetServicesUseCase getServicesUseCase;
  final GetRestaurantsUseCase getRestaurantsUseCase;

  HomeBloc(this.getServicesUseCase, this.getRestaurantsUseCase)
    : super(const HomeState()) {
    on<LoadServicesEvent>(_onLoadServices);
    on<LoadRestaurantsEvent>(_onLoadRestaurants);
  }

  Future<void> _onLoadServices(
    LoadServicesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoadingServices: true, servicesError: null));
    try {
      final services = await getServicesUseCase();
      emit(state.copyWith(services: services, isLoadingServices: false));
    } catch (e) {
      emit(
        state.copyWith(isLoadingServices: false, servicesError: e.toString()),
      );
    }
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurantsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoadingRestaurants: true, restaurantsError: null));
    try {
      final restaurants = await getRestaurantsUseCase();
      emit(
        state.copyWith(restaurants: restaurants, isLoadingRestaurants: false),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingRestaurants: false,
          restaurantsError: e.toString(),
        ),
      );
    }
  }
}
