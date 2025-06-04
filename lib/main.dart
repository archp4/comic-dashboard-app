import 'package:appwrite_flutter_starter_kit/app.dart';
import 'package:appwrite_flutter_starter_kit/utils/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await AppInitializer.initialize();
  runApp(AppwriteApp());
}
