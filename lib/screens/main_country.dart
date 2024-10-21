// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:countries/Cubit/Countires%20Cubit/cubit/countries_cubit.dart';
import 'package:countries/data/repository/get_countries_repo.dart';
import 'package:countries/screens/Countires_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainCountry extends StatefulWidget {
  const MainCountry({super.key});

  @override
  State<MainCountry> createState() => _MainCountryState();
}

class _MainCountryState extends State<MainCountry> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    double statusBarHeight = MediaQuery.of(context).padding.top;

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
              // ignore: sized_box_for_whitespace
              Container(
                width: mediaQuery.size.width * 1 / 3,
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
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          context.read<CountriesCubit>().getCountries();
          Navigator.pop(
            context,
          );
          Navigator.pop(
            context,
          );
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Countries(),
            ),
          );
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            height: mediaQuery.size.height -
                statusBarHeight -
                ((landscape)
                    ? (mediaQuery.size.height * (90 / 800))
                    : (mediaQuery.size.height * (70 / 800))),
            color: (Day_mode)
                ? const Color.fromARGB(255, 237, 234, 234)
                : const Color.fromARGB(255, 60, 58, 58),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      color: (Day_mode == true)
                          ? Colors.white
                          : const Color.fromARGB(255, 87, 83, 83),
                      width: mediaQuery.size.width * 0.25,
                      height: (landscape)
                          ? mediaQuery.size.height * 0.08
                          : mediaQuery.size.height * 0.05,
                      margin: EdgeInsets.only(
                          top: mediaQuery.size.height * 0.03,
                          left: mediaQuery.size.width * 0.05),
                      child: InkWell(
                        onTap: () {
                          context.read<CountriesCubit>().getCountries();
                          Navigator.pop(
                            context,
                          );
                          Navigator.pop(
                            context,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const Countries(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Day_mode ? Colors.black : Colors.white,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                color: Day_mode ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Center(
                  child: Container(
                    constraints: const BoxConstraints(
                        minHeight: 250, minWidth: 200, maxWidth: 500.0),
                    width: mediaQuery.size.width * 0.9,
                    height: mediaQuery.size.height -
                        (mediaQuery.size.height * 0.03) -
                        statusBarHeight -
                        ((landscape)
                            ? ((mediaQuery.size.height * (90 / 800) +
                                (mediaQuery.size.height * 0.08)))
                            : ((mediaQuery.size.height * (70 / 800)) +
                                (mediaQuery.size.height * 0.05))),
                    child: BlocBuilder<CountriesCubit, CountriesState>(
                      builder: (context, state) {
                        if (state is UsersDataSuccess) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              margin: EdgeInsets.only(
                                  top: mediaQuery.size.height * 0.04),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                          minHeight: 125,
                                          minWidth: 200,
                                          maxWidth: 500),
                                      width: mediaQuery.size.width * 0.9,
                                      height: mediaQuery.size.height * 2.5 / 10,
                                      child: Image.network(
                                        countries[selected_country].flags.png,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        countries[selected_country]
                                            .name
                                            .official,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Day_mode
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                      margin: EdgeInsets.only(
                                          top: mediaQuery.size.height * 0.02,
                                          bottom:
                                              mediaQuery.size.height * 0.02),
                                    ),
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Native Name: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Day_mode
                                                            ? Colors.black
                                                            : Colors.white)),
                                                TextSpan(
                                                  text: (countries[
                                                                  selected_country]
                                                              .name
                                                              .nativeName
                                                              .values
                                                              .first
                                                              .values
                                                              .first
                                                              .toString() ==
                                                          '')
                                                      ? countries[
                                                              selected_country]
                                                          .name
                                                          .common
                                                          .toString()
                                                      : utf8
                                                          .decode(countries[
                                                                  selected_country]
                                                              .name
                                                              .nativeName
                                                              .values
                                                              .first
                                                              .values
                                                              .first
                                                              .runes
                                                              .toList())
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ]))),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Population: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Day_mode
                                                            ? Colors.black
                                                            : Colors.white)),
                                                TextSpan(
                                                  text: (countries[
                                                                  selected_country]
                                                              .population
                                                              .toString() ==
                                                          '')
                                                      ? 'No Population'
                                                      : countries[
                                                              selected_country]
                                                          .population
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ]))),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Region: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                                TextSpan(
                                                  text: (countries[
                                                                  selected_country]
                                                              .region
                                                              .toString() ==
                                                          '')
                                                      ? 'No Region'
                                                      : countries[
                                                              selected_country]
                                                          .region
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ]))),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Sup Region: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                                TextSpan(
                                                  text: (countries[
                                                                  selected_country]
                                                              .subregion
                                                              .toString() ==
                                                          '')
                                                      ? 'No Sup Region'
                                                      : countries[
                                                              selected_country]
                                                          .subregion
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ]))),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Capital: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                                TextSpan(
                                                  text: (countries[
                                                                  selected_country]
                                                              .capital
                                                              .first
                                                              .toString() ==
                                                          '')
                                                      ? 'No Capital'
                                                      : countries[
                                                              selected_country]
                                                          .capital
                                                          .first
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ]))),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: 'Currencies:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Day_mode
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          TextSpan(
                                            text: (countries[selected_country]
                                                        .currencies
                                                        .values
                                                        .first
                                                        .values
                                                        .first
                                                        .toString() ==
                                                    '')
                                                ? 'No Sup Region'
                                                : countries[selected_country]
                                                    .currencies
                                                    .values
                                                    .first
                                                    .values
                                                    .first
                                                    .toString(),
                                            style: TextStyle(
                                                color: Day_mode
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ]))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: 'Languages:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Day_mode
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          TextSpan(
                                            text: (countries[selected_country]
                                                        .languages
                                                        .values
                                                        .toString() ==
                                                    '')
                                                ? 'No Sup Region'
                                                : countries[selected_country]
                                                    .languages
                                                    .values
                                                    .toString(),
                                            style: TextStyle(
                                                color: Day_mode
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ]))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Border Countries:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                                TextSpan(
                                                  text:
                                                      // ignore: prefer_is_empty
                                                      (countries[selected_country]
                                                                  .borders
                                                                  .length ==
                                                              0)
                                                          ? 'No Borders'
                                                          : '',
                                                  style: TextStyle(
                                                      color: Day_mode
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ]))),
                                          // ignore: avoid_unnecessary_containers, prefer_is_empty
                                          (countries[selected_country]
                                                      .borders
                                                      .length ==
                                                  0)
                                              // ignore: prefer_const_constructors
                                              ? SizedBox(
                                                  height: 10,
                                                )
                                              // ignore: avoid_unnecessary_containers
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                countries[
                                                                        selected_country]
                                                                    .borders
                                                                    .length;
                                                            i++)
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    left: 10,
                                                                    right: 10,
                                                                    bottom: 5),
                                                            color: (Day_mode ==
                                                                    true)
                                                                ? Colors.white
                                                                : const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    87,
                                                                    83,
                                                                    83),
                                                            child: Center(
                                                              child: Text(
                                                                countries[
                                                                        selected_country]
                                                                    .borders[i]
                                                                    .toString(),
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
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        } else if (state is UsersDataError) {
                          return Center(
                            child: Text(state.errorMessage),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
