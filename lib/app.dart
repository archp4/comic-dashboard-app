import 'package:appwrite_flutter_starter_kit/ui/views/auth.dart';
import 'package:flutter/material.dart';

class AppwriteApp extends StatelessWidget {
  const AppwriteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite Comic Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AuthView(),
    );
  }
}
