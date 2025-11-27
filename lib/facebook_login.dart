// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class FacebookLoginScreen extends StatefulWidget {
  const FacebookLoginScreen({super.key});

  @override
  State<FacebookLoginScreen> createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  bool _isLoading = false;

  void _simulateFacebookLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Simula o processo de login do Facebook
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });

    // Retorna para a tela anterior com sucesso
    Navigator.pop(context, true);
  }

  void _cancelLogin() {
    Navigator.pop(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4267B2),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF4267B2),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _cancelLogin,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Conteúdo
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo do Facebook
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4267B2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.facebook,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Título
                      const Text(
                        'Continuar com Facebook',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Descrição
                      const Text(
                        'Você será redirecionado para o Facebook para autorizar o acesso',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      // Informações de permissão
                      _buildPermissionItem('Ver seu perfil público'),
                      _buildPermissionItem('Acessar seu endereço de email'),
                      _buildPermissionItem('Ver suas informações básicas'),

                      const SizedBox(height: 30),

                      // Botão de login
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _simulateFacebookLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4267B2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Continuar como Usuário',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: _cancelLogin,
                        child: const Text(
                          'Não agora',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
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

  Widget _buildPermissionItem(String permission) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(permission, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
