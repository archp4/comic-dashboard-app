import 'package:appwrite_flutter_starter_kit/data/repository/appwrite_repository.dart';
import 'package:appwrite_flutter_starter_kit/ui/components/auth/login_form.dart';
import 'package:appwrite_flutter_starter_kit/ui/components/auth/singup_form.dart';
import 'package:appwrite_flutter_starter_kit/ui/views/home.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;
  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  void initState() {
    AppwriteRepository().isUserLoggedIn().then(
      (isLoggedIn) {
        if (isLoggedIn) {
          toHome();
        }
      },
    );
    super.initState();
  }

  void toHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth View"),
      ),
      body: Center(
        child: isLogin
            ? LoginForm(onAuthChange: toggleView)
            : SignUpForm(onAuthChange: toggleView),
      ),
    );
  }
}
