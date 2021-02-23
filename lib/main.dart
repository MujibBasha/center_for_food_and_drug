import 'package:center_for_food_and_drug/localization/demo_localization.dart';
import 'package:center_for_food_and_drug/screens/login_screen/login_screen2.dart';
import 'package:center_for_food_and_drug/screens/main_screen/inst_dashboard_screen.dart';

import 'package:center_for_food_and_drug/screens/registration_screen/signup_screen.dart';
import 'package:center_for_food_and_drug/tasks_provider/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ProviderData(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      routes: {
        InstDashboardScreen.id: (context) => InstDashboardScreen(),
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0XFF0A0E21),
        scaffoldBackgroundColor: Color(0XFF0A0E21),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          subtitle: TextStyle(color: Colors.white),
        ),
      ),
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('ar', 'SA'), // Arabic, no country code
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      home: SafeArea(child: LoginScreen()),
    );
  }
}
