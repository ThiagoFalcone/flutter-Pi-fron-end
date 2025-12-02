// custom_change_notifier.dart
import 'package:flutter/widgets.dart';

// Classe base para os seus providers
abstract class CustomChangeNotifier extends ChangeNotifier {}

// Custom ChangeNotifierProvider
class ChangeNotifierProvider<T extends CustomChangeNotifier>
    extends StatefulWidget {
  final T Function() create;
  final Widget child;

  const ChangeNotifierProvider({
    super.key,
    required this.create,
    required this.child,
  });

  static T of<T extends CustomChangeNotifier>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<_InheritedProvider<T>>();
    if (provider == null) {
      throw FlutterError(
        'ChangeNotifierProvider.of() called with a context that does not contain a $T.',
      );
    }
    return provider.notifier;
  }

  @override
  State<ChangeNotifierProvider<T>> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends CustomChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  late T _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = widget.create();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedProvider<T>(notifier: _notifier, child: widget.child);
  }
}

class _InheritedProvider<T extends CustomChangeNotifier>
    extends InheritedWidget {
  final T notifier;

  const _InheritedProvider({required super.child, required this.notifier});

  @override
  bool updateShouldNotify(_InheritedProvider<T> oldWidget) {
    return true;
  }
}

// Consumer widget para facilitar o uso
class Consumer<T extends CustomChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  const Consumer({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context), null);
  }
}
