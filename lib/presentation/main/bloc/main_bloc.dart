import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState(currentIndex: 0)) {
    on<ChangePageEvent>((event, emit) {
      emit(MainState(currentIndex: event.index));
    });
  }
}