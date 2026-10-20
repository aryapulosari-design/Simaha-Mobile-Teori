/// Explicit demo launch: flutter run -d windows --dart-define=SIMAHA_DEMO=true
class AppRuntime {
  AppRuntime._();
  static const bool isDemo = bool.fromEnvironment('SIMAHA_DEMO');
  static const String demoPin = '123456';
  static const String demoDatabaseName = 'simaha_demo.db';
}
