import 'package:flutter/material.dart';
import 'package:flutter_teste/auth_service.dart';
import 'package:flutter_teste/facebook_login.dart';
import 'package:flutter_teste/google_login_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

  // Serviço de autenticação simulado
  final AuthService _authService = AuthService();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        _showSnackBar('As senhas não coincidem');
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final result = await _authService.registerWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
          nickname: _nicknameController.text,
        );

        if (result.success) {
          _showSnackBar('Cadastro realizado com sucesso!');
          _navigateToLogin();
        } else {
          _showSnackBar('Erro no cadastro: ${result.errorMessage}');
        }
      } catch (e) {
        _showSnackBar('Erro ao realizar cadastro: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _registerWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      // Navega para a tela de login do Google
      final success = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (context) => const GoogleLoginScreen()),
      );

      if (success == true) {
        _showSnackBar('Registro com Google realizado com sucesso!');
        _navigateToHome();
      } else {
        _showSnackBar('Login com Google cancelado');
      }
    } catch (e) {
      _showSnackBar('Erro no registro com Google: $e');
    } finally {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }

  Future<void> _registerWithFacebook() async {
    setState(() {
      _isFacebookLoading = true;
    });

    try {
      // Navega para a tela de login do Facebook
      final success = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (context) => const FacebookLoginScreen()),
      );

      if (success == true) {
        _showSnackBar('Registro com Facebook realizado com sucesso!');
        _navigateToHome();
      } else {
        _showSnackBar('Login com Facebook cancelado');
      }
    } catch (e) {
      _showSnackBar('Erro no registro com Facebook: $e');
    } finally {
      setState(() {
        _isFacebookLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF667EEA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _navigateToHome() {
    _showSnackBar('Login social realizado! Navegando para home...');

    // Em uma aplicação real, você navegaria para a tela principal:
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF667EEA),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  _buildHeader(),
                  const SizedBox(height: 48.0),

                  // FORM CARD
                  _buildRegisterForm(),
                  const SizedBox(height: 32.0),

                  // SOCIAL LOGIN
                  _buildSocialLogin(),
                  const SizedBox(height: 24.0),

                  // LINK PARA LOGIN
                  _buildLoginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Criar Conta',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Preencha os dados para se cadastrar',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // CAMPO NICKNAME
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'Nickname',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(
                      hintText: 'Seu nickname',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite um nickname';
                      }
                      if (value.length < 3) {
                        return 'O nickname deve ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // CAMPO EMAIL
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'seu@email.com',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite seu e-mail';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Por favor, digite um e-mail válido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // CAMPO SENHA
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'Senha',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Sua senha',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite sua senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // CAMPO CONFIRMAR SENHA
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                  child: Text(
                    'Confirmar Senha',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirme sua senha',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _register(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // BOTÃO CADASTRAR
            Container(
              width: double.infinity,
              height: 52.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667EEA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        // DIVISOR
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.white.withOpacity(0.3),
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ou cadastre-se com',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.white.withOpacity(0.3),
                thickness: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),

        // BOTÕES SOCIAIS (apenas Google e Facebook)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              Icons.g_mobiledata,
              'Google',
              const Color(0xFFDB4437),
              _isGoogleLoading,
              _registerWithGoogle,
            ),
            const SizedBox(width: 40.0), // Aumentei o espaçamento
            _buildSocialButton(
              Icons.facebook,
              'Facebook',
              const Color(0xFF4267B2),
              _isFacebookLoading,
              _registerWithFacebook,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String label,
    Color color,
    bool isLoading,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: onPressed,
                  icon: Icon(icon, size: 28.0, color: color),
                ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Já tem uma conta?',
          style: TextStyle(color: Colors.white70, fontSize: 14.0),
        ),
        const SizedBox(width: 8.0),
        TextButton(
          onPressed: _navigateToLogin,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: const Text(
            'Fazer Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }
}
