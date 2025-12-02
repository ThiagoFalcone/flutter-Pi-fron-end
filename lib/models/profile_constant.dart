// constants/profile_constants.dart
import 'package:flutter/material.dart';
import '../models/user_status.dart';
import '../models/share_option.dart';

class ProfileConstants {
  // URLs das logos das plataformas
  static final Map<String, String> platformLogos = {
    'steam':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Steam_icon_logo.svg/512px-Steam_icon_logo.svg.png',
    'psn':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Playstation_logo_colour.svg/512px-Playstation_logo_colour.svg.png',
    'xbox':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Xbox_one_logo.svg/512px-Xbox_one_logo.svg.png',
    'nintendo':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Nintendo.svg/512px-Nintendo.svg.png',
  };

  // Opções de status
  static final List<UserStatus> statusOptions = [
    UserStatus('Online', Icons.circle, Color(0xFF10B981)),
    UserStatus('Ocupado', Icons.remove_circle, Color(0xFFF59E0B)),
    UserStatus('Ausente', Icons.timer, Color(0xFF6366F1)),
    UserStatus('Offline', Icons.circle_outlined, Color(0xFF94A3B8)),
    UserStatus('Jogando', Icons.sports_esports, Color(0xFF8B5CF6)),
    UserStatus('Não perturbe', Icons.do_not_disturb, Color(0xFFEF4444)),
  ];

  // Opções de compartilhamento
  static final List<ShareOption> shareOptions = [
    ShareOption(
      'WhatsApp',
      Icons.chat,
      Color(0xFF25D366),
      'https://web.whatsapp.com/',
    ),
    ShareOption(
      'Facebook',
      Icons.facebook,
      Color(0xFF1877F2),
      'https://facebook.com/',
    ),
    ShareOption(
      'Instagram',
      Icons.camera_alt,
      Color(0xFFE4405F),
      'https://instagram.com/',
    ),
    ShareOption(
      'Discord',
      Icons.chat_bubble,
      Color(0xFF5865F2),
      'https://discord.com/',
    ),
    ShareOption(
      'Twitter',
      Icons.trending_up,
      Color(0xFF1DA1F2),
      'https://twitter.com/',
    ),
    ShareOption('Copiar Link', Icons.link, Color(0xFF64748B), null),
  ];

  // Cores clean - paleta suave
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Colors.white;
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);

  // Status padrão
  static final UserStatus defaultStatus = UserStatus(
    'Online',
    Icons.circle,
    Color(0xFF10B981),
  );

  // URLs de avatar padrão
  static const List<String> defaultAvatarUrls = [
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
    'https://images.unsplash.com/photo-1494790108755-2616b786d4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
  ];

  // IDs de jogos de exemplo
  static const List<String> exampleGameIds = ['1', '7', '3', '4', '5'];
}
