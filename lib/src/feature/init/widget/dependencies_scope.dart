import 'package:audio_challenge/src/feature/init/model/app_dependencies.dart';
import 'package:flutter/widgets.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    required super.child,
    required this.dependencies,
    super.key,
  });

  final AppDependencies dependencies;

  static AppDependencies of(BuildContext context) {
    final container =
        context.getInheritedWidgetOfExactType<DependenciesScope>();
    if (container == null) {
      throw Exception('DependencyContainer not found in the widget tree');
    }
    return container.dependencies;
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
