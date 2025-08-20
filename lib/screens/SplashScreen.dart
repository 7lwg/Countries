// ignore_for_file: file_names

import 'dart:async';

import 'package:countries/Cubit/Countires%20Cubit/cubit/countries_cubit.dart';
import 'package:countries/screens/Countires_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/get_countries_repo.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<bool> getPrefs() async {
      final prefs = await SharedPreferences.getInstance();
      Day_mode = prefs.getBool('Day_mode')!;
      return Day_mode;
    }

    getPrefs();
    context.read<CountriesCubit>().getCountries();
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Countries(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Center(
          // ignore: sized_box_for_whitespace
          child: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              child: FittedBox(
                  child: Lottie.asset('assets/Animation.json',
                      fit: BoxFit.cover)))),
    );
  }
}
