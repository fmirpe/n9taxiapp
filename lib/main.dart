import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/map_provider.dart';
import 'providers/user_provider.dart';
import 'screens/map_screen.dart';
import 'screens/login_signup_screen.dart';

import 'screens/onboarding_screen.dart';
import 'screens/trips_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBpyrJlOBgcTcOgCsZqqLv_gdq_7lUUi34',
      appId: '1:31172218743:android:0451162c780fdecb7c5b72',
      messagingSenderId: '31172218743',
      projectId: 'n9driverapp',
      storageBucket: 'n9driverapp.appspot.com',
    ),
  );
  runApp(const TaxiApp());
}

class TaxiApp extends StatelessWidget {
  const TaxiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: MapProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'N9 Taxi App',
        theme: theme,
        initialRoute: OnboardingScreen.route,
        routes: {
          OnboardingScreen.route: (_) => const OnboardingScreen(),
          MapScreen.route: (_) => const MapScreen(),
          LoginSignupScreen.route: (_) => const LoginSignupScreen(),
          TripsScreen.route: (_) => const TripsScreen(),
        },
      ),
    );
  }
}
