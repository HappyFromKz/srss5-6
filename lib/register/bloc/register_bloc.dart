import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:practice_7/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {


  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterButtonPressed) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email.trim(), 
            password: event.password.trim(),
          );

          sharedPreference.setEmail(event.email.trim());
          sharedPreference.setPhone(event.phone.trim());
          emit(RegisterSuccess());
        } catch (e) {
          emit(RegisterError(e.toString()));
        }
      }
    });
  }
}