import 'package:intl/intl.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite_flutter_starter_kit/data/models/log.dart';
import 'package:appwrite_flutter_starter_kit/data/models/project_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppwriteRepository {
  static const String pingPath = "/ping";
  static String appwriteProjectId = dotenv.env['APPWRITE_PROJECT_ID']!;
  static String appwriteProjectName = dotenv.env['APPWRITE_PROJECT_NAME']!;
  static String appwritePublicEndpoint =
      dotenv.env['APPWRITE_PUBLIC_ENDPOINT']!;

  final Client _client = Client()
      .setProject(appwriteProjectId)
      .setEndpoint(appwritePublicEndpoint);

  late final Account _account;
  late final Databases _databases;

  AppwriteRepository._internal() {
    _account = Account(_client);
    _databases = Databases(_client);
  }

  Account get account => _account;
  Databases get databases => _databases;

  static final AppwriteRepository _instance = AppwriteRepository._internal();

  factory AppwriteRepository() => _instance;

  ProjectInfo getProjectInfo() {
    return ProjectInfo(
      endpoint: appwritePublicEndpoint,
      projectId: appwriteProjectId,
      projectName: appwriteProjectName,
    );
  }

  Future<bool> isUserLoggedIn() {
    return _account
        .get()
        .then((user) => user.$id.isNotEmpty)
        .catchError((_) => false);
  }

  Future<Log> ping() async {
    try {
      final response = await _client.ping();

      return Log(
        date: _getCurrentDate(),
        status: 200,
        method: "GET",
        path: pingPath,
        response: response,
      );
    } on AppwriteException catch (error) {
      return Log(
        date: _getCurrentDate(),
        status: error.code ?? 500,
        method: "GET",
        path: pingPath,
        response: error.message ?? "Unknown error",
      );
    }
  }

  Future<Log> login({required String email, required String password}) async {
    try {
      final response = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );

      return Log(
        date: _getCurrentDate(),
        status: 200,
        method: "GET",
        path: "/create",
        response: response.toString(),
      );
    } on AppwriteException catch (error) {
      return Log(
        date: _getCurrentDate(),
        status: error.code ?? 500,
        method: "/create",
        path: pingPath,
        response: error.message ?? "Unknown error",
      );
    }
  }

  String _getCurrentDate() {
    return DateFormat("MMM dd, HH:mm").format(DateTime.now());
  }
}
