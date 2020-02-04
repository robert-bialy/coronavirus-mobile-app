class InformationBlock {
  int confirmed = 0;
  int deaths = 0;
  int recovered = 0;
  int countriesAffected = 0;
  DateTime lastUpdate;

  InformationBlock.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> summary = json['worldStats'];
    confirmed = summary['confirmed'] as int;
    deaths = summary['deaths'] as int;
    recovered = summary['recovered'] as int;
    countriesAffected = summary['countriesAffected'] as int;
  }
}