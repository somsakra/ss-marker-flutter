part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserEventLogin extends UserEvent {
  final Credential credential;

  const UserEventLogin({required this.credential});
}

class UserEventInitial extends UserEvent {}
