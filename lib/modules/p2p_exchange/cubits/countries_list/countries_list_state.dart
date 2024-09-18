import 'package:dollarax/modules/p2p_exchange/models/countries_list_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';


enum CountriesListStatus {
  initial,
  loading,
  success,
  error,
}

class CountriesListState {

  final CountriesListStatus countriesListStatus;
  final List<CountryListModel> countriesList;
  final String message;

  CountriesListState( {required this.countriesListStatus,required this.countriesList,required this.message });

  factory CountriesListState.Initial(){
    return CountriesListState(countriesListStatus: CountriesListStatus.initial, countriesList : [], message: "" );
  }



  CountriesListState copyWith({
    CountriesListStatus? countriesListStatus,
    List<CountryListModel>? countriesList,
    String? message,
  }) {
    return CountriesListState(
      countriesListStatus: countriesListStatus ?? this.countriesListStatus,
      countriesList: countriesList ?? this.countriesList,
      message: message ?? this.message,
    );
  }
}
