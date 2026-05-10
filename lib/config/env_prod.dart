import 'package:movegui_admin_panel/config/env.dart';

class EnvProd extends Env {
  @override
  String get apiUrl => "https://movegui.com";

  @override
  bool get enableLogs => true;
  
  @override
  AppEnv get currentEnv => AppEnv.prod;
  
  @override
  String get port => "5000";
  
}