// models/share_option.dart

import 'package:flutter/material.dart';

class ShareOption {
  final String name;
  final IconData icon;
  final Color color;
  final String? url;

  ShareOption(this.name, this.icon, this.color, this.url);

  // Método para converter para Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconCodePoint': icon.codePoint,
      'color': color.value,
      'url': url,
    };
  }

  // Método para criar a partir de Map
  factory ShareOption.fromMap(Map<String, dynamic> map) {
    return ShareOption(
      map['name'] as String,
      IconData(map['iconCodePoint'] as int, fontFamily: 'MaterialIcons'),
      Color(map['color'] as int),
      map['url'] as String?,
    );
  }

  // Método para cópia com possíveis alterações
  ShareOption copyWith({
    String? name,
    IconData? icon,
    Color? color,
    String? url,
  }) {
    return ShareOption(
      name ?? this.name,
      icon ?? this.icon,
      color ?? this.color,
      url ?? this.url,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShareOption &&
        other.name == name &&
        other.icon.codePoint == icon.codePoint &&
        other.color == color &&
        other.url == url;
  }

  @override
  int get hashCode =>
      name.hashCode ^ icon.codePoint ^ color.hashCode ^ url.hashCode;

  @override
  String toString() {
    return 'ShareOption(name: $name, icon: $icon, color: $color, url: $url)';
  }
}
