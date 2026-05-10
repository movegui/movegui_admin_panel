import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movegui_admin_panel/app_router.dart';
import 'package:movegui_admin_panel/config/env.dart';
import 'package:movegui_admin_panel/config/env_prod.dart';
import 'package:movegui_admin_panel/config/firebase_config.dart';
import 'package:movegui_admin_panel/consts/theme_data.dart';
import 'package:movegui_admin_panel/firebase_options.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<UserModel>('user_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final env = EnvProd();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),

    // ... other providers
  ]);
  initServices();
    await FirebaseConfig.init(env);

  runApp( MyApp(env: env,));
}

class MyApp extends StatefulWidget {

final Env env;
  const MyApp({super.key, required this.env , });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  final getIt = GetIt.instance;

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider
        .darkThemePreference
        .getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeChangeProvider),
        ChangeNotifierProvider(create: (_) => AppbarTitleProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
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
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
