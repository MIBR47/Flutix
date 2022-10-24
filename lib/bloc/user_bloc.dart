// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

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

    on<UpdateDataEvent>((event, emit) async {
      UserModel updatedUser = (state as UserLoadedState).user.copyWith(name: event.name, profilePicture: event.profileImage);
      print(event.profileImage);
      await UserServices.updateUser(updatedUser);

      emit(UserLoadedState(updatedUser));
    });

    on<TopupEvent>((event, emit) async {
      if (state is UserLoadedState) {
        try {
          UserModel updatedUser = (state as UserLoadedState).user.copyWith(balance: (state as UserLoadedState).user.balance! + event.amount);
          await UserServices.updateUser(updatedUser);

          emit(UserLoadedState(updatedUser));
        } catch (e) {
          print(e);
        }
      }
    });

    on<PurchaseEvent>((event, emit) async {
      if (state is UserLoadedState) {
        try {
          UserModel updatedUser = (state as UserLoadedState).user.copyWith(balance: (state as UserLoadedState).user.balance! - event.amount);
          await UserServices.updateUser(updatedUser);

          emit(UserLoadedState(updatedUser));
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
