import 'package:astrologeradmin/constance/language/app_localization.dart';
import 'package:astrologeradmin/constance/language/constant.dart';
import 'package:astrologeradmin/provider/LanguageSelectionProvider.dart';
import 'package:astrologeradmin/provider/dashboard_provider.dart';
import 'package:astrologeradmin/provider/language_provider.dart';
import 'package:astrologeradmin/provider/auth_provider.dart';
import 'package:astrologeradmin/provider/splash_provider.dart';
import 'package:astrologeradmin/provider/theme_provider.dart';
import 'package:astrologeradmin/services/ApiService.dart';
import 'package:astrologeradmin/views/splash_view/splash_view.dart';
import 'package:astrologeradmin/views/video_Call/controllers/video_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'provider/chat_provider.dart';
Future<void> configure() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
}
Future<void> main() async {
  await configure();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AstrologerChatProvider(),),
            ChangeNotifierProvider(create: (_) => VideoProvider()),
            ChangeNotifierProvider(create: (_) => BottomSheetSelectionProvider()),
            ChangeNotifierProvider(create: (_) => SplashProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => LanguageNotifier()),
            ChangeNotifierProvider(create: (_) => DashboardProvider())
          ],
          child: const MyApp())
    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context,themeProvider,child){
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.isDarkMode? ThemeData.dark():ThemeData.light(),
          home: SplashView(),
          //SplashView(),
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('hi', '')
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        ),
      );
    });
  }
}


