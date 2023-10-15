import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/Expenses.dart';
import 'package:flutter/services.dart';

var colorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 87, 221, 245));

var darkColorScheme =
    ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.black);
void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    
  });*/
  runApp(
    MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        cardTheme: const CardTheme().copyWith(
            color: darkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primaryContainer,
          foregroundColor: darkColorScheme.onPrimaryContainer,
        )),
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: colorScheme,
          cardTheme: const CardTheme().copyWith(
              color: colorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
          )),
          textTheme: const TextTheme().copyWith(
            titleLarge: TextStyle(
                color: colorScheme.primaryContainer,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                color: colorScheme.onSecondaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            titleSmall: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontSize: 14,
            ),
          ),
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: colorScheme.onPrimaryContainer,
            foregroundColor: colorScheme.primaryContainer,
          )),
      home: const Expenses(),
    ),
  );
}
