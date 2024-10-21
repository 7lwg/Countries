import 'dart:io';

import 'package:countries/Cubit/Countires%20Cubit/cubit/countries_cubit.dart';
import 'package:countries/Cubit/Search%20Cubit/search_cubit_cubit.dart';
import 'package:countries/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

String selectedRegionItem = 'all';
// ignore: non_constant_identifier_names
bool SelectedRegion = false;
// ignore: non_constant_identifier_names

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubitCubit>(
          create: (BuildContext context) => SearchCubitCubit(),
        ),
        BlocProvider<CountriesCubit>(
          create: (BuildContext context) => CountriesCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
