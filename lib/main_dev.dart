import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movegui_admin_panel/app_router.dart';
import 'package:movegui_admin_panel/app_theme.dart';
import 'package:movegui_admin_panel/config/env.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/config/firebase_config.dart';
import 'package:movegui_admin_panel/firebase_options.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/services/init_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<UserModel>('user_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final env = EnvDev();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),

    // ... other providers
  ]);
  initServices(env);
  await FirebaseConfig.init(env);
  // await  createSuperUser();
  runApp(ProviderScope(child: MoveguiAdminApp(env: env)));
}

/*
class MoveguiAdminApp extends ConsumerWidget {
  final Env env;

  const MoveguiAdminApp({super.key, required this.env});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(DarkThemeProvider.themeProvider);
    final router = ref.watch(AppRouter.routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('fr'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      title: 'Movegui Panel',
      theme: Styles.themeData(themeProvider.getDarkTheme, context),
      routerConfig: router,
    );
  }
}
*/

class MoveguiAdminApp extends ConsumerStatefulWidget {
  const MoveguiAdminApp({super.key, required this.env});

  final Env env;

  @override
  ConsumerState<MoveguiAdminApp> createState() => _MoveguiAdminAppState();
}

class _MoveguiAdminAppState extends ConsumerState<MoveguiAdminApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await createSuperUser(context);
      await createSupportUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(DarkThemeProvider.themeProvider);
    final router = ref.watch(AppRouter.routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('fr'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      title: 'Movegui Panel',
      //  theme: Styles.themeData(themeProvider.getDarkTheme, context),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }

  /*
  MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
)
   */
}
