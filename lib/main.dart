import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/search_screen.dart';
import 'screens/login_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  runApp(const FlightTrackerApp());
}

class FlightTrackerApp extends StatelessWidget {
  const FlightTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('authBox'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          final authBox = Hive.box('authBox');
          final isLoggedIn = authBox.get('isLoggedIn', defaultValue: false);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flight Tracker',
            theme: appTheme,
            home: isLoggedIn ? const SearchScreen() : const LoginScreen(),
          );
        }
      },
    );
  }
}
