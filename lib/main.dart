import 'package:butyprovider/Base/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'Base/AllTranslation.dart';
import 'Base/Translations.dart';
import 'UI/Auth/spash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType();
    print(newLocale.languageCode);
    state.setState(() => state.local = newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale local;
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();

  @override
  void initState() {
    super.initState();
    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });

    Future<PermissionStatus> permissionStatus =
        NotificationPermissions.getNotificationPermissionStatus();
    permissionStatus.then((status) {
      print("======> $status");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: local,
      supportedLocales: allTranslations.supportedLocales(),
      localizationsDelegates: [
        TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //------------------make iphone back with swipe-----------------
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        //---------------------------------------------------------------
        primaryColor: Color(0xFFDBB2D2),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white))
      ),
      home: Splash(
        navKey: navKey,
      ),
    );
  }
}
