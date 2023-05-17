import 'package:buddywatch_app/login.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:buddywatch_app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wvfhqncgwctjtjclsqgt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind2ZmhxbmNnd2N0anRqY2xzcWd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA2MDc1MjcsImV4cCI6MTk5NjE4MzUyN30.lXzjweqUh89SkAuAva8qAXPLXvk5u8dOOtHfhDFEJXQ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuddyWatch',
      home: StreamBuilder<AuthState>(
          stream: AuthService().onAuthStateChange(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.event) {
                case AuthChangeEvent.passwordRecovery:
                // TODO: Handle this case.
                  break;
                case AuthChangeEvent.signedIn:
                  return const Home();
                case AuthChangeEvent.signedOut:
                  return const Login();
                case AuthChangeEvent.tokenRefreshed:
                // TODO: Handle this case.
                  break;
                case AuthChangeEvent.userUpdated:
                // TODO: Handle this case.
                  break;
                case AuthChangeEvent.userDeleted:
                // TODO: Handle this case.
                  break;
                case AuthChangeEvent.mfaChallengeVerified:
                // TODO: Handle this case.
                  break;
              }
            }
            return AuthService().isLoggedIn() ? const Home() : const Login();
          }
      ),
    );
  }
}
