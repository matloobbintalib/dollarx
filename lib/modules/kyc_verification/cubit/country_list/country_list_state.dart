
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';

enum CountryListStatus {
  initial,
  loading,
  success,
  error,
}

class CountryListState {

  final CountryListStatus countryListStatus;
  final List<CountryModel> countryLists;
  final String message;

  CountryListState( {required this.countryListStatus,required this.countryLists,required this.message});

  factory CountryListState.Initial(){
    return CountryListState(countryListStatus: CountryListStatus.initial, countryLists : [], message: "");
  }



  CountryListState copyWith({
    CountryListStatus? countryListStatus,
    List<CountryModel>? countryLists,
    String? message,
  }) {
    return CountryListState(
      countryListStatus: countryListStatus ?? this.countryListStatus,
      countryLists: countryLists ?? this.countryLists,
      message: message ?? this.message,
    );
  }
}
