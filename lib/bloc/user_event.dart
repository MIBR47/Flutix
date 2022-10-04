part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {
  final String id;
  const LoadUserEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SignOutEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateDataEvent extends UserEvent {
  final String? name;
  final String? profileImage;
  const UpdateDataEvent({this.name, this.profileImage});
  @override
  List<Object> get props => [name!, profileImage!];
}
