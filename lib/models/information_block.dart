class InformationBlock {
  String country;
  String state;
  int confirmed = 0;
  int deaths = 0;
  int recovered = 0;
  int countriesAffected = 0;
  DateTime lastUpdate;

  InformationBlock.fromSummaryJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'] as int;
    deaths = json['deaths'] as int;
    recovered = json['recovered'] as int;
    countriesAffected = json['countriesAffected'] as int;
  }

  InformationBlock.fromCountriesJson(Map<String, dynamic> json) {
    country = json['country'] as String;
    state = json['state'] as String;
    confirmed = json['confirmed'] as int;
    deaths = json['deaths'] as int;
    recovered = json['recovered'] as int;
    countriesAffected = json['countriesAffected'] as int;
  }
}