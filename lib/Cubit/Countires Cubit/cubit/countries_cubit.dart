import 'package:bloc/bloc.dart';
// import 'package:countries/data/model/get_countries_model.dart';
import 'package:countries/data/repository/get_countries_repo.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitial());

  GetCountriesRepo usersRepo = GetCountriesRepo();

  Future<void> getCountries() async {
    emit(UsersDataLoading());

    try {
      await usersRepo.getCountriesData().then((value) {
        if (value != null) {
          emit(UsersDataSuccess());
        } else {
          if (search_countries_text == '') {
            emit(UsersDataError('Failed to fetch Data'));
          } else {
            emit(UsersDataError('No results found'));
          }
        }
      });
    } catch (error) {
      emit(UsersDataError('An error occurred'));
    }
  }
}
