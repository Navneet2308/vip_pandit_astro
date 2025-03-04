import 'package:astrologeradmin/provider/splash_provider.dart';
import 'package:astrologeradmin/provider/theme_provider.dart';
import 'package:astrologeradmin/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> get appProviders1 {
  return [
    ChangeNotifierProvider(create: (_) => SplashProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => LanguageNotifier()),
  ];
}

List<ChangeNotifierProvider<ChangeNotifier>> appProviders() =>
    [
      ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LanguageNotifier()),
    ];
