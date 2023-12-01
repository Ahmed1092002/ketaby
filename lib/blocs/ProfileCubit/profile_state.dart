part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {}

class GetProfileError extends ProfileState {}
class ProfileImagePickedSuccessState extends ProfileState {}
class ProfileImagePickedErrorState extends ProfileState {}
class LogoutErrorState extends ProfileState {}
class LogoutSuccessState extends ProfileState {}
class LogoutLoadingState extends ProfileState {}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileError extends ProfileState {}

