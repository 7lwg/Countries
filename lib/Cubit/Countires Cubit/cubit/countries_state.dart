part of 'countries_cubit.dart';

@immutable
sealed class CountriesState {}

final class CountriesInitial extends CountriesState {}

final class UsersDataLoading extends CountriesState {}

final class UsersDataSuccess extends CountriesState {}

final class UsersDataError extends CountriesState {
  late final String errorMessage;
  UsersDataError(this.errorMessage);
  List<Object> get props => [errorMessage];
}

final class GenderRadioButton extends CountriesState {}
