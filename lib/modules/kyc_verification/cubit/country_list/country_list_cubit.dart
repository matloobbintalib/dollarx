import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/kyc_verification/cubit/country_list/country_list_state.dart';
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';
import 'package:dollarax/modules/kyc_verification/repo/kyc_verification_repository.dart';
import '../../../../core/exceptions/api_error.dart';
class CountryListCubit extends Cubit<CountryListState> {
  final KycVerificationRepository _repository;

  CountryListCubit(this._repository) : super(CountryListState.Initial());

  Future<void> countryLists() async {
    emit(state.copyWith(countryListStatus: CountryListStatus.loading));
    try {
      CountryListResponse countryListsResponse =
      await _repository.getCountriesList();
      if (countryListsResponse.status == 200) {
        emit(state.copyWith(
            countryListStatus: CountryListStatus.success,
            countryLists: countryListsResponse.data,
            message: countryListsResponse.message));
      } else {
        emit(state.copyWith(
            countryListStatus: CountryListStatus.error,
            message: countryListsResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          countryListStatus: CountryListStatus.error, message: e.message));
    }
  }
}
