class Flags {
  final String png;
  final String svg;
  final String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      png: json['png'],
      svg: json['svg'],
      alt: json['alt'],
    );
  }
}

class Name {
  final String common;
  final String official;
  final Map<String, Map<String, String>> nativeName;

  Name(
      {required this.common, required this.official, required this.nativeName});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      common: json['common'],
      official: json['official'],
      nativeName: (json['nativeName'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, Map<String, String>.from(value))),
    );
  }
}

class GetCountriesModel {
  final Flags flags;
  final Name name;
  final List<String> capital;
  final String region;
  final String subregion;
  final Map<String, dynamic> languages;
  final List<String> borders;
  final int population;
  final Map<String, Map<String, String>> currencies;

  GetCountriesModel({
    required this.flags,
    required this.name,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.borders,
    required this.population,
    required this.currencies,
  });

  factory GetCountriesModel.fromJson(Map<String, dynamic> json) {
    return GetCountriesModel(
      flags: Flags.fromJson(json['flags']),
      name: Name.fromJson(json['name']),
      capital: List<String>.from(json['capital']),
      region: json['region'],
      subregion: json['subregion'],
      languages: json['languages'],
      borders: List<String>.from(json['borders']),
      population: json['population'],
      currencies: (json['currencies'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, Map<String, String>.from(value))),
    );
  }
}
