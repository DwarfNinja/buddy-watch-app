import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  get data => null;

  User? getUser() {
    return supabase.auth.currentUser;
  }

  Future<AuthResponse> logIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    return await supabase.auth.signOut();
  }

  Future<AuthResponse> signUp(String firstName, String proposition,
                              String lastName, int age, int height,
                              int weight, String email, String password) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'first_name': firstName,
        'proposition': proposition,
        'last_name': lastName,
        'age': age,
        'height': height,
        'weight': weight
      }
    );
  }
  
  Future<UserResponse> updateUser(String firstName, String proposition,
                                  String lastName, int age, int height,
                                  int weight, String email, String password) async {
    return await supabase.auth.updateUser(
      {
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'proposition': proposition,
          'last_name': lastName,
          'age': age,
          'height': height,
          'weight': weight
        }
      } as UserAttributes
    );
  }

  Stream<AuthState> onAuthStateChange() {
    return supabase.auth.onAuthStateChange;
  }

  bool isLoggedIn() {
    final session = AuthService().supabase.auth.currentSession;
    return session != null ? true : false;
  }
}