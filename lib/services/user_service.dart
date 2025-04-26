import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static final String _apiKey = dotenv.env['REQRES_API_KEY'] ?? '';

  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('https://reqres.in/api/login');
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': _apiKey,
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        if (token != null) {
          var authBox = await Hive.openBox('authBox');
          await authBox.put('isLoggedIn', true);
          await authBox.put('token', token);

          print('✅ Zalogowano. Token zapisany.');
          return true;
        } else {
          print('⚠️ Brak tokenu w odpowiedzi.');
        }
      } else {
        print('❌ Błąd logowania: ${response.body}');
      }
    } catch (e) {
      print('❌ Wyjątek podczas logowania: $e');
    }

    return false;
  }

  static Future<void> logout() async {
    var authBox = await Hive.openBox('authBox');
    await authBox.clear();
    print('ℹ️ Wylogowano.');
  }
}
