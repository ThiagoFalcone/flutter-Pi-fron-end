// models/user_status.dart

import 'package:flutter/material.dart';

class UserStatus {
  final String name;
  final IconData icon;
  final Color color;

  UserStatus(this.name, this.icon, this.color);

  // Método para converter para Map (para salvar no SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconCodePoint': icon.codePoint,
      'color': color.value,
    };
  }

  // Método para criar a partir de Map
  factory UserStatus.fromMap(Map<String, dynamic> map) {
    return UserStatus(
      map['name'] as String,
      IconData(map['iconCodePoint'] as int, fontFamily: 'MaterialIcons'),
      Color(map['color'] as int),
    );
  }

  // Método para cópia com possíveis alterações
  UserStatus copyWith({String? name, IconData? icon, Color? color}) {
    return UserStatus(
      name ?? this.name,
      icon ?? this.icon,
      color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserStatus &&
        other.name == name &&
        other.icon.codePoint == icon.codePoint &&
        other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ icon.codePoint ^ color.hashCode;

  @override
  String toString() {
    return 'UserStatus(name: $name, icon: $icon, color: $color)';
  }
}
