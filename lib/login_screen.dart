// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_teste/services/auth_service.dart';
import 'register_screen.dart';
import 'catalogo_screen.dart';
import 'google_login_screen.dart';
import 'facebook_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [Color(0x0016BFC4), Color(0x8016BFC4)],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [Color(0x804BE8CC), Color(0x0016BFC4)],
        ),
      ),
    );
  }

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Preencha todos os campos');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await authService.loginWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
    );

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (result.success) {
      _showSnackBar('Login realizado com sucesso!');
      _navigateToCatalog();
    } else {
      _showSnackBar(result.errorMessage ?? 'Erro desconhecido');
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      final success = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (context) => const GoogleLoginScreen()),
      );

      if (success == true) {
        _showSnackBar('Login com Google realizado com sucesso!');
        _navigateToCatalog();
      } else {
        _showSnackBar('Login com Google cancelado');
      }
    } catch (e) {
      _showSnackBar('Erro no login com Google: $e');
    } finally {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }

  Future<void> _loginWithFacebook() async {
    setState(() {
      _isFacebookLoading = true;
    });

    try {
      final success = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (context) => const FacebookLoginScreen()),
      );

      if (success == true) {
        _showSnackBar('Login com Facebook realizado com sucesso!');
        _navigateToCatalog();
      } else {
        _showSnackBar('Login com Facebook cancelado');
      }
    } catch (e) {
      _showSnackBar('Erro no login com Facebook: $e');
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
        backgroundColor: const Color(0xFF16BFC4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void _navigateToCatalog() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GamesCatalogScreen()),
    );
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Recuperar Senha',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Digite seu e-mail para recuperar a senha:',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'seu@email.com',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('E-mail de recuperação enviado!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16BFC4),
            ),
            child: const Text('Enviar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Background elements
            Positioned(
              top: -160,
              left: -30,
              child: topWidget(screenSize.width),
            ),
            Positioned(
              bottom: -180,
              left: -40,
              child: bottomWidget(screenSize.width),
            ),

            // Main content
            SafeArea(
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
                      _buildLoginForm(),
                      const SizedBox(height: 32.0),

                      // SOCIAL LOGIN
                      _buildSocialLogin(),
                      const SizedBox(height: 24.0),

                      // FOOTER LINKS
                      _buildFooterLinks(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bem-vindo de volta!',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF16BFC4),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Faça login para continuar',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[400],
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
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
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'seu@email.com',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    fillColor: Colors.grey[800],
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textInputAction: TextInputAction.next,
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
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Sua senha',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    fillColor: Colors.grey[800],
                    filled: true,
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
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _login(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // BOTÃO ENTRAR
          Container(
            width: double.infinity,
            height: 52.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF16BFC4).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16BFC4),
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
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
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
                color: Colors.grey.withOpacity(0.6),
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ou continue com',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.withOpacity(0.6),
                thickness: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),

        // BOTÕES SOCIAIS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              Icons.g_mobiledata,
              'Google',
              Colors.white,
              const Color(0xFF4285F4),
              _isGoogleLoading,
              _loginWithGoogle,
            ),
            const SizedBox(width: 40.0),
            _buildSocialButton(
              Icons.facebook,
              'Facebook',
              Colors.white,
              const Color(0xFF4267B2),
              _isFacebookLoading,
              _loginWithFacebook,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String label,
    Color iconColor,
    Color backgroundColor,
    bool isLoading,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: onPressed,
                  icon: Icon(icon, size: 28.0, color: iconColor),
                ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      children: [
        // ESQUECI A SENHA
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: _forgotPassword,
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(
                color: const Color(0xFF16BFC4),
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        // CADASTRO
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não tem uma conta?',
              style: TextStyle(color: Colors.grey[400], fontSize: 14.0),
            ),
            const SizedBox(width: 8.0),
            TextButton(
              onPressed: _navigateToRegister,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: Text(
                'Cadastre-se',
                style: TextStyle(
                  color: const Color(0xFF16BFC4),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
