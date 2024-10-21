import 'dart:convert';
import 'package:countries/data/model/get_countries_model.dart';
import 'package:countries/main.dart';
import 'package:http/http.dart' as http;

List<GetCountriesModel> countries = [];
// ignore: non_constant_identifier_names
String search_countries_text = "";
// ignore: prefer_typing_uninitialized_variables
var response;
// ignore: non_constant_identifier_names
bool first_item = true;
// ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
var selected_country;
// ignore: non_constant_identifier_names
bool Day_mode = true;

String decodedText = '';

class GetCountriesRepo {
  Future<String?> getCountriesData() async {
    try {
      // if (SelectedRegion == false || selectedRegionItem == 'all') {
      if (selectedRegionItem != 'all') {
        response = await http.get(Uri.parse(
            'https://restcountries.com/v3.1/region/$selectedRegionItem?fields=name,population,region,subregion,capital,languages,borders,flags,currencies'));
      } else {
        if (search_countries_text != "") {
          response = await http.get(Uri.parse(
              'https://restcountries.com/v3.1/name/$search_countries_text?fields=name,population,region,subregion,capital,languages,borders,flags,currencies'));
        } else {
          response = await http.get(Uri.parse(
              'https://restcountries.com/v3.1/all?fields=name,population,region,subregion,capital,languages,borders,flags,currencies'));
        }
      }

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(response.body);
        countries = decodedResponse
            .map((json) => GetCountriesModel.fromJson(json))
            .toList();

        if (SelectedRegion = true && search_countries_text != "") {
          countries = decodedResponse
              .map((json) => GetCountriesModel.fromJson(json))
              .toList()
              .where((element) => element.name.common
                  .toString()
                  .toLowerCase()
                  .contains(search_countries_text.toLowerCase()))
              .toList();
        }
        return "";
      } else {
        return null;
      }
    } catch (error) {
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print("error: " + error.toString());
      return null;
    }
  }
}
