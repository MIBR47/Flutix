import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    // ignore: void_checks
    // on<UserEvent>((event, emit) async* {
    //   // UserModel user =
    //   if (event is LoadUserEvent) {
    //     UserModel user = await UserServices.getUser(event.id);
    //     yield UserLoadedState(user);
    //   } else if (event is SignOutEvent) {
    //     yield UserInitialState();
    //   }
    // });

    on<LoadUserEvent>(
      (event, emit) async {
        UserModel user = await UserServices.getUser(event.id);

        emit(UserLoadedState(user));
      },
    );
    on<SignOutEvent>(
      (event, emit) async => emit(UserInitialState()),
    );
  }
}
