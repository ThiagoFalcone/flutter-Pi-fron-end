import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_config.dart';

class AuthService {
  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/usuario/logar');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final user = User(
          id: data['id'].toString(),
          email: data['email'],
          nickname: data['nome'] ?? 'Usuário',
        );

        return AuthResult(success: true, user: user);
      } else {
        return AuthResult(
          success: false,
          errorMessage: 'Credenciais inválidas ou erro no servidor',
        );
      }
    } catch (e) {
      return AuthResult(success: false, errorMessage: 'Erro de conexão: $e');
    }
  }

  Future<AuthResult> registerWithEmail({
    required String email,
    required String password,
    required String nickname,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/usuario');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nickname,
          'email': email,
          'senha': password,
          'bio': 'Minha biografia',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final user = User(
          id: data['id'].toString(),
          email: data['email'],
          nickname: data['nome'],
        );

        return AuthResult(success: true, user: user);
      } else {
        return AuthResult(
          success: false,
          errorMessage: 'Erro no cadastro: ${response.body}',
        );
      }
    } catch (e) {
      return AuthResult(success: false, errorMessage: 'Erro de conexão: $e');
    }
  }

  // Simula login com Google
  Future<AuthResult> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simula abertura do seletor de contas do Google
    // Em uma app real, isso abriria a tela de login do Google

    return AuthResult(
      success: true,
      user: User(
        id: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'usuario@gmail.com',
        nickname: 'Usuário Google',
      ),
    );
  }

  // Simula login com Facebook
  Future<AuthResult> signInWithFacebook() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simula abertura do login do Facebook
    // Em uma app real, isso abriria a tela de login do Facebook

    return AuthResult(
      success: true,
      user: User(
        id: 'facebook_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'usuario@facebook.com',
        nickname: 'Usuário Facebook',
      ),
    );
  }

  // Simula login com Apple
  Future<AuthResult> signInWithApple() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simula abertura do login da Apple
    // Em uma app real, isso abriria a tela de login da Apple

    return AuthResult(
      success: true,
      user: User(
        id: 'apple_user_${DateTime.now().millisecondsSinceEpoch}',
        email: 'usuario@apple.com',
        nickname: 'Usuário Apple',
      ),
    );
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
