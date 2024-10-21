import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'search_cubit_state.dart';

class SearchCubitCubit extends Cubit<SearchCubitState> {
  SearchCubitCubit() : super(SearchCubitInitial());

  bool search = false;

  // ignore: non_constant_identifier_names
  void search_icon() {
    if (search == true) {
      search = false;
    } else {
      search = true;
    }
    emit(SearchCubitInitial());
  }

  // ignore: non_constant_identifier_names
  void close_search() {
    search = false;
    emit(SearchCubitInitial());
  }
}
