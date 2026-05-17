import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  await Hive.openBox('categoriesBox');
  await Hive.openBox('itemsBox');
  await Hive.openBox('salesBox');
   await Hive.openBox('appBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
