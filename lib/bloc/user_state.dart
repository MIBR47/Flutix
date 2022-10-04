part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel user;
  const UserLoadedState(this.user);
  @override
  List<Object> get props => [user];
}

class UserUpdateState extends UserState {
  final UserModel user;
  const UserUpdateState(this.user);
  @override
  List<Object> get props => [user];
}
