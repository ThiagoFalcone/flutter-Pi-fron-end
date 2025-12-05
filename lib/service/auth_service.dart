import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_config.dart';

class AuthService {
  /// Cadastro de usuário
  Future<AuthResult> registerWithEmail({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/usuario'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "nome": nickname,
          "email": email,
          "senha": password,
          "bio": "Novo usuário cadastrado via app",
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return AuthResult(
          success: true,
          user: User(
            id: data['id'].toString(),
            email: data['email'],
            nickname: data['nome'],
          ),
        );
      } else {
        return AuthResult(
          success: false,
          errorMessage: "Erro ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      return AuthResult(success: false, errorMessage: e.toString());
    }
  }

  /// Login de usuário
  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/usuario/logar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "senha": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AuthResult(
          success: true,
          user: User(
            id: data['id'].toString(),
            email: data['email'],
            nickname: data['nome'],
          ),
        );
      } else {
        return AuthResult(
          success: false,
          errorMessage: "Credenciais inválidas",
        );
      }
    } catch (e) {
      return AuthResult(success: false, errorMessage: e.toString());
    }
  }
}

class AuthResult {
  final bool success;
  final String? errorMessage;
  final User? user;

  AuthResult({required this.success, this.errorMessage, this.user});
}

class User {
  final String id;
  final String email;
  final String nickname;

  User({required this.id, required this.email, required this.nickname});
}
