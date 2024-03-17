import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>  {

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      print('${event} event');
      if (event is LoginButtonPressed) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email.trim(), 
              password: event.password.trim(),
            );
          emit(LoginSuccess());
        } catch (e) {
          emit(LoginError(e.toString()));
        }
      }
    });
  }
}