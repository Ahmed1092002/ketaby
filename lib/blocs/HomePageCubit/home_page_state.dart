part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}
class GetSliderLoading extends HomePageState {}
class GetSliderSuccess extends HomePageState {}
class GetSliderError extends HomePageState {}
class GetBestSellerLoading extends HomePageState {}
class GetBestSellerSuccess extends HomePageState {}
class GetBestSellerError extends HomePageState {}
class GetCategoryLoading extends HomePageState {}
class GetCategorySuccess extends HomePageState {}
class GetCategoryError extends HomePageState {}
class GetNewArrivalLoading extends HomePageState {}
class GetNewArrivalSuccess extends HomePageState {}
class GetNewArrivalError extends HomePageState {}
