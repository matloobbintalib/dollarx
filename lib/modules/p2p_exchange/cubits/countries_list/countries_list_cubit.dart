import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/countries_list/countries_list_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/countries_list_response.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class CountriesListCubit extends Cubit<CountriesListState> {
  final P2PRepository _repository;

  CountriesListCubit(this._repository) : super(CountriesListState.Initial());


  Future<void> getAllCountries() async {
    emit(state.copyWith(countriesListStatus: CountriesListStatus.loading));
    try {
      CountriesListResponse response = await _repository.getAllCountries();
      if (response.status == 200) {
        emit(state.copyWith(
            countriesListStatus: CountriesListStatus.success,
            countriesList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            countriesListStatus: CountriesListStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          countriesListStatus: CountriesListStatus.error, message: e.message));
    }
  }
}
