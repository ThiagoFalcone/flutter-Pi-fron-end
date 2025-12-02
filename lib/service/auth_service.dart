// auth_service.dart
class AuthService {
  // Simula registro com email e senha
  Future<AuthResult> registerWithEmail({
    required String email,
    required String password,
    required String nickname,
  }) async {
    // Simula delay de rede
    await Future.delayed(const Duration(seconds: 2));

    // Validações simples
    if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
      return AuthResult(
        success: false,
        errorMessage: 'Todos os campos são obrigatórios',
      );
    }

    if (password.length < 6) {
      return AuthResult(
        success: false,
        errorMessage: 'A senha deve ter pelo menos 6 caracteres',
      );
    }

    // Simula sucesso
    return AuthResult(
      success: true,
      user: User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        nickname: nickname,
      ),
    );
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
