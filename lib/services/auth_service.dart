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

  Future<AuthResponse> signUp(String firstName, String preposition, String lastName, String birthDate, int height, int weight, String email, String password) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'first_name': firstName,
        'prepostion': preposition,
        'last_name': lastName,
        "date_of_birth": birthDate,
        'height': height,
        'weight': weight,
      }
    );
  }
  
  Future<UserResponse> updateUser(String firstName, String proposition, String lastName, String birthDate, int height, int weight, String email, String password) async {
    return await supabase.auth.updateUser(
      UserAttributes(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'prepostion': proposition,
          'last_name': lastName,
          "date_of_birth": birthDate,
          'height': height,
          'weight': weight,
        }
      )
    );
  }

  Future<List<dynamic>> getProfile() async {
    return await supabase.from('profiles')
        .select('*')
        .eq('id', supabase.auth.currentUser!.id);
  }

  Future<List<dynamic>> updateProfile(String firstName, String proposition, String lastName, String birthDate, int height, int weight) async {
    return await supabase.from('profiles')
        .update(
        {
          'first_name': firstName,
          'prepostion': proposition,
          'last_name': lastName,
          "date_of_birth": birthDate,
          'height': height,
          'weight': weight,
        }
        )
        .eq('id', supabase.auth.currentUser!.id).select();
  }

  Stream<AuthState> onAuthStateChange() {
    return supabase.auth.onAuthStateChange;
  }

  bool isLoggedIn() {
    final session = AuthService().supabase.auth.currentSession;
    return session != null ? true : false;
  }
}