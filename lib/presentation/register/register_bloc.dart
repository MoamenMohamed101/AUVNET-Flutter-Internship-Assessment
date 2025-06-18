import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawel/domain/usecase/register_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterPressed>((event, emit) async {
      emit(RegisterLoading());
      if (event.password != event.confirmPassword) {
        emit(RegisterFailure("Passwords do not match."));
        return;
      }
      try {
        await registerUseCase.register(event.email, event.password);
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}