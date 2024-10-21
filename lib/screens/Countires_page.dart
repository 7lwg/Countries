// ignore_for_file: file_names
import 'package:countries/Cubit/Countires%20Cubit/cubit/countries_cubit.dart';
import 'package:countries/Cubit/Search%20Cubit/search_cubit_cubit.dart';
import 'package:countries/data/repository/get_countries_repo.dart';
import 'package:countries/main.dart';
import 'package:countries/screens/main_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  List<String> items = [
    'Filter by region',
    'Africa',
    'America',
    'Asia',
    'Europe',
    'Oceania',
    'all'
  ];

  @override
  void initState() {
    super.initState();
    Future<bool> abc() async {
      final prefs = await SharedPreferences.getInstance();
      Day_mode = prefs.getBool("Day_mode") as bool;
      setState(() {});
      return Day_mode;
    }

    abc();
  }

  // ignore: prefer_final_fields
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: (landscape)
            ? (mediaQuery.size.height * (90 / 800))
            : (mediaQuery.size.height * (70 / 800)),
        backgroundColor: (Day_mode == true)
            ? Colors.white
            : const Color.fromARGB(255, 87, 83, 83),
        automaticallyImplyLeading: false,
        title: Container(
          width: mediaQuery.size.width,
          margin: EdgeInsets.only(
              left: mediaQuery.size.width * 0.01,
              right: mediaQuery.size.width * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                width: mediaQuery.size.width * 1.5 / 3,
                child: FittedBox(
                  child: Text(
                    'Where in the world?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Day_mode ? Colors.black : Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (Day_mode == true) {
                    Day_mode = false;
                  } else {
                    Day_mode = true;
                  }
                  setState(() {});
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("Day_mode", Day_mode) as bool;
                },
                child: Container(
                  width: mediaQuery.size.width * 1 / 4,
                  constraints: BoxConstraints(
                      maxHeight: mediaQuery.size.height * 0.08, maxWidth: 125),
                  child: Row(
                    children: [
                      Container(
                          width: mediaQuery.size.width * 0.04,
                          constraints: BoxConstraints(
                              maxHeight: mediaQuery.size.height * 0.03,
                              maxWidth: 20),
                          child: FittedBox(
                              child: Icon(
                            (Day_mode)
                                ? Icons.nightlight_round_sharp
                                : Icons.sunny,
                            color: Day_mode ? Colors.black : Colors.white,
                          ))),
                      Container(
                          width: (landscape)
                              ? mediaQuery.size.width * 0.08
                              : mediaQuery.size.width * 0.20,
                          constraints: BoxConstraints(
                              maxHeight: mediaQuery.size.height * 0.08,
                              maxWidth: 100),
                          height: (landscape)
                              ? mediaQuery.size.height * 0.08
                              : mediaQuery.size.height * 0.03,
                          child: FittedBox(
                              child: Text(
                            (Day_mode) ? ' Dark mode' : ' Light mode',
                            style: TextStyle(
                                color: Day_mode ? Colors.black : Colors.white),
                          ))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: (Day_mode)
              ? const Color.fromARGB(255, 237, 234, 234)
              : const Color.fromARGB(255, 60, 58, 58),
          child: Column(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.2,
                  child: BlocBuilder<SearchCubitCubit, SearchCubitState>(
                    builder: (context, state) {
                      return Container(
                        child: (landscape == true)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: mediaQuery.size.height * 0.9,
                                    constraints:
                                        const BoxConstraints(maxWidth: 450),
                                    child: TextFormField(
                                      controller: _textEditingController,
                                      onChanged: (text) {
                                        search_countries_text = text;
                                        context
                                            .read<CountriesCubit>()
                                            .getCountries();
                                      },
                                      textAlign: TextAlign.start,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextStyle(
                                          color: (Day_mode)
                                              ? const Color.fromARGB(
                                                  255, 87, 83, 83)
                                              : Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: mediaQuery.size.width * 0.02,
                                            bottom:
                                                mediaQuery.size.width * 0.02),
                                        prefixIcon: Container(
                                          width: mediaQuery.size.width * 0.1,
                                          constraints: const BoxConstraints(
                                              maxWidth: 50),
                                          child: Icon(
                                            Icons.search,
                                            color: (Day_mode)
                                                ? const Color.fromARGB(
                                                    255, 145, 142, 142)
                                                : Colors.white,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: (Day_mode)
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 87, 83, 83),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'Search for country...',
                                        hintStyle: TextStyle(
                                            color: (Day_mode)
                                                ? const Color.fromARGB(
                                                    255, 87, 83, 83)
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<CountriesCubit, CountriesState>(
                                    builder: (context, state) {
                                      return Container(
                                          decoration: BoxDecoration(
                                              color: (Day_mode == true)
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 87, 83, 83),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: mediaQuery.size.width * 0.5,
                                          constraints: const BoxConstraints(
                                              maxWidth: 200),
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 25),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              dropdownColor: (Day_mode)
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 87, 83, 83),
                                              iconEnabledColor:
                                                  (Day_mode == true)
                                                      ? const Color.fromARGB(
                                                          255, 87, 83, 83)
                                                      : Colors.white,
                                              iconDisabledColor:
                                                  (Day_mode == true)
                                                      ? const Color.fromARGB(
                                                          255, 87, 83, 83)
                                                      : Colors.white,
                                              value: (first_item)
                                                  ? items[0]
                                                  : selectedRegionItem,
                                              style: TextStyle(
                                                  color: (Day_mode == true)
                                                      ? const Color.fromARGB(
                                                          255, 87, 83, 83)
                                                      : Colors.white),
                                              items: items
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                          value: item,
                                                          child: Text(item)))
                                                  .toList(),
                                              onChanged: (item) {
                                                if (item == items[0]) {
                                                  selectedRegionItem = "all";
                                                  search_countries_text = "";
                                                  _textEditingController
                                                      .clear();
                                                } else {
                                                  first_item = false;
                                                  selectedRegionItem =
                                                      item.toString();
                                                  search_countries_text = "";
                                                  _textEditingController
                                                      .clear();
                                                }
                                                SelectedRegion = true;
                                                context
                                                    .read<CountriesCubit>()
                                                    .getCountries();
                                              },
                                              elevation: 0,
                                            ),
                                          ));
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: mediaQuery.size.width * 0.9,
                                    constraints:
                                        const BoxConstraints(maxWidth: 450),
                                    child: TextFormField(
                                      controller: _textEditingController,
                                      onChanged: (text) {
                                        search_countries_text = text;
                                        context
                                            .read<CountriesCubit>()
                                            .getCountries();
                                      },
                                      textAlign: TextAlign.left,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextStyle(
                                          color: (Day_mode)
                                              ? const Color.fromARGB(
                                                  255, 87, 83, 83)
                                              : Colors.white),
                                      decoration: InputDecoration(
                                        prefixIcon: Container(
                                          width: mediaQuery.size.width * 0.1,
                                          constraints: const BoxConstraints(
                                              maxWidth: 30),
                                          child: Icon(
                                            Icons.search,
                                            color: (Day_mode)
                                                ? const Color.fromARGB(
                                                    255, 145, 142, 142)
                                                : Colors.white,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: (Day_mode)
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 87, 83, 83),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'Search for country...',
                                        hintStyle: TextStyle(
                                            color: (Day_mode)
                                                ? const Color.fromARGB(
                                                    255, 87, 83, 83)
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<CountriesCubit, CountriesState>(
                                    builder: (context, state) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: (Day_mode == true)
                                                    ? Colors.white
                                                    : const Color.fromARGB(
                                                        255, 87, 83, 83),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            width: mediaQuery.size.width * 0.5,
                                            height:
                                                mediaQuery.size.height * 0.06,
                                            constraints: const BoxConstraints(
                                                maxWidth: 200),
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 25),
                                            margin: EdgeInsets.only(
                                              left:
                                                  mediaQuery.size.width * 0.04,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                dropdownColor: (Day_mode)
                                                    ? Colors.white
                                                    : const Color.fromARGB(
                                                        255, 87, 83, 83),
                                                iconEnabledColor:
                                                    (Day_mode == true)
                                                        ? const Color.fromARGB(
                                                            255, 87, 83, 83)
                                                        : Colors.white,
                                                iconDisabledColor:
                                                    (Day_mode == true)
                                                        ? const Color.fromARGB(
                                                            255, 87, 83, 83)
                                                        : Colors.white,
                                                value: (first_item == true)
                                                    ? items[0]
                                                    : selectedRegionItem,
                                                style: TextStyle(
                                                    color: (Day_mode == true)
                                                        ? const Color.fromARGB(
                                                            255, 87, 83, 83)
                                                        : Colors.white),
                                                items: items
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                                String>(
                                                            value: item,
                                                            child: Text(item)))
                                                    .toList(),
                                                onChanged: (item) {
                                                  if (item == items[0]) {
                                                    selectedRegionItem = "all";
                                                    search_countries_text = "";
                                                    _textEditingController
                                                        .clear();
                                                  } else {
                                                    first_item = false;
                                                    selectedRegionItem =
                                                        item.toString();
                                                    search_countries_text = "";
                                                    _textEditingController
                                                        .clear();
                                                  }
                                                  SelectedRegion = true;

                                                  context
                                                      .read<CountriesCubit>()
                                                      .getCountries();
                                                },
                                                elevation: 0,
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      );
                    },
                  )),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 200, maxWidth: 400.0),
                    width: mediaQuery.size.width * 0.7,
                    height: (landscape)
                        ? mediaQuery.size.height -
                            ((mediaQuery.size.height * 0.2) +
                                (mediaQuery.size.height * (90 / 800)) +
                                MediaQuery.of(context).padding.top)
                        : mediaQuery.size.height -
                            ((mediaQuery.size.height * 0.2) +
                                (mediaQuery.size.height * (70 / 800)) +
                                MediaQuery.of(context).padding.top),
                    child: BlocBuilder<CountriesCubit, CountriesState>(
                      builder: (context, state) {
                        if (state is UsersDataSuccess) {
                          // ignore: prefer_is_empty
                          return (countries.length == 0)
                              ? Center(
                                  child: Text(
                                    'No results found',
                                    style: TextStyle(
                                        color: (Day_mode == true)
                                            ? const Color.fromARGB(
                                                255, 87, 83, 83)
                                            : Colors.white),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: countries.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MainCountry(),
                                              ),
                                            );
                                            SelectedRegion = false;
                                            first_item = true;
                                            search_countries_text = "";
                                            _textEditingController.clear();
                                            selected_country = index;
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                bottom: mediaQuery.size.height *
                                                    0.06,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: (Day_mode)
                                                      ? Colors.white
                                                      : const Color.fromARGB(
                                                          255, 87, 83, 83),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minHeight: 125,
                                                            minWidth: 150,
                                                            maxWidth: 500),
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.7,
                                                    height:
                                                        mediaQuery.size.height *
                                                            2 /
                                                            10,
                                                    child: Image.network(
                                                      countries[index]
                                                          .flags
                                                          .png,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    // ignore: sort_child_properties_last
                                                    child: Text(
                                                      countries[index]
                                                          .name
                                                          .official,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Day_mode
                                                              ? Colors.black
                                                              : Colors.white),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: mediaQuery
                                                                .size.width *
                                                            0.05,
                                                        top: mediaQuery
                                                                .size.height *
                                                            0.02,
                                                        bottom: mediaQuery
                                                                .size.height *
                                                            0.02),
                                                  ),
                                                  // ignore: avoid_unnecessary_containers
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          // ignore: sort_child_properties_last
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "population: ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Day_mode
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                              Text(
                                                                countries[index]
                                                                    .population
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Day_mode
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                            ],
                                                          ),
                                                          margin: EdgeInsets.only(
                                                              left: mediaQuery
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          // ignore: sort_child_properties_last
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Region: ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Day_mode
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                              Text(
                                                                countries[index]
                                                                    .region
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Day_mode
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                            ],
                                                          ),
                                                          margin: EdgeInsets.only(
                                                              left: mediaQuery
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          // ignore: sort_child_properties_last
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Capital: ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Day_mode
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                              Text(
                                                                countries[index]
                                                                    .capital
                                                                    .first
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Day_mode
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white),
                                                              ),
                                                            ],
                                                          ),
                                                          margin: EdgeInsets.only(
                                                              left: mediaQuery
                                                                      .size
                                                                      .width *
                                                                  0.05),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        mediaQuery.size.height *
                                                            0.02,
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    );
                                  });
                        } else if (state is UsersDataError) {
                          return Center(
                            child: Text(state.errorMessage,
                                style: TextStyle(
                                    color: (Day_mode == true)
                                        ? const Color.fromARGB(255, 87, 83, 83)
                                        : Colors.white)),
                          );
                        } else {
                          return FutureBuilder<void>(
                            future:
                                context.read<CountriesCubit>().getCountries(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                      "An error occurred while loading data."),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
