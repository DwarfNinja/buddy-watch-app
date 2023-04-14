import 'package:buddywatch_app/login.dart';
import 'package:buddywatch_app/register.dart';
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
    return const MaterialApp(
      title: 'BuddyWatch',
      home: Login(),
    );
  }
}
