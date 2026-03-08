import 'package:book_store_app_bloc_cubit/core/di/injection.dart';
import 'package:book_store_app_bloc_cubit/ui/home/home_screen.dart';
import 'package:book_store_app_bloc_cubit/ui/splash/controllers/auth_cubit.dart';
import 'package:book_store_app_bloc_cubit/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/strings/strings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthGate());
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..listenAuthState(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthStateUnAuthenticated) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SplashScreen()));
          }
          if (state is AuthStateAuthenticated) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        },
        child: Scaffold(body: Center(child: Text(Strings.connectionError))),
      ),
    );
  }
}
