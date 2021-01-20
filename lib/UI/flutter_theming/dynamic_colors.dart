import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tinycolor/tinycolor.dart';

import 'color_config.dart';

class DynamicTheme extends StatefulWidget {
  final Widget child;
  final GlobalKey globalKey;

  DynamicTheme({this.child, this.globalKey}) : super(key: globalKey);

  @override
  DynamicThemeState createState() => new DynamicThemeState();
}

class DynamicThemeState extends State<DynamicTheme> {
  ThemeData _theme;
  ThemeData _darkTheme;
  ThemeData _lightTheme;

  set primary(Color newPrimary) {
    setState(() {
      _darkTheme = _darkTheme.copyWith(
          primaryColor: newPrimary,
          accentColor: newPrimary,
          highlightColor: newPrimary.withOpacity(0.1));
      _lightTheme = _lightTheme.copyWith(
          primaryColor: newPrimary,
          accentColor: newPrimary,
          highlightColor: newPrimary.withOpacity(0.1));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initTheme();
    _theme = MediaQuery.of(context).platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return DynamicThemeHelper(
      appThemeKey: widget.globalKey,
      child: Theme(
        data: _theme,
        child: widget.child,
      ),
    );
  }

  // Helpers
  void _initTheme() {
    if (_theme != null) return;

    var currentLanguage = Intl.getCurrentLocale();
    var fontFamily = currentLanguage == 'ar' ? 'Tajawal' : 'PublicSans';
    var fontSizeDelta = currentLanguage == 'ar' ? 0.0 : 0.0;

    // TODO: Should be done from remote configs
    ColorThemeConfigs lightThemeConfig = lightTheme;
    ColorThemeConfigs darkThemeConfig = darkTheme;

    _lightTheme = ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(lightThemeConfig.primary),
        accentColor: Color(lightThemeConfig.secondary),
        backgroundColor: Color(lightThemeConfig.surfaceDim),
        scaffoldBackgroundColor: Color(lightThemeConfig.surfaceBright),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
        dividerColor: Color(lightThemeConfig.border),
        cardColor: Color(lightThemeConfig.surfaceBright),
        highlightColor: Color(lightThemeConfig.primary).withOpacity(0.1),
        textTheme: Theme.of(context)
            .textTheme
            .apply(
                fontFamily: fontFamily,
                fontSizeDelta: fontSizeDelta,
                displayColor: Color(lightThemeConfig.textHead),
                bodyColor: Color(lightThemeConfig.textBody))
            .copyWith(
                overline: Theme.of(context).textTheme.overline.copyWith(
                    color: Color(lightThemeConfig.textBody),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                caption: Theme.of(context).textTheme.caption.copyWith(
                    color: Color(lightThemeConfig.textBody),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Color(lightThemeConfig.textBody),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Color(lightThemeConfig.textHead),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                headline6: Theme.of(context).textTheme.headline6.copyWith(
                    color: Color(lightThemeConfig.textHead),
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                headline5: Theme.of(context).textTheme.headline5.copyWith(
                    color: Color(lightThemeConfig.textHead),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                headline4: Theme.of(context).textTheme.headline4.copyWith(
                    color: Color(lightThemeConfig.textHead),
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                    fontFamily: fontFamily)),
        appBarTheme: AppBarTheme(elevation: 0.0, color: Color(lightThemeConfig.surfaceBright)),
        colorScheme: Theme.of(context).colorScheme.copyWith(onPrimary: TinyColor(Color(lightThemeConfig.primary)).isLight() ? Colors.black : Colors.white));

    _darkTheme = ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(darkThemeConfig.primary),
        accentColor: Color(darkThemeConfig.secondary),
        backgroundColor: Color(darkThemeConfig.surfaceBright),
        scaffoldBackgroundColor: Color(darkThemeConfig.surfaceDim),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
        dividerColor: Color(darkThemeConfig.border),
        cardColor: Color(darkThemeConfig.surfaceDim),
        highlightColor: Color(darkThemeConfig.primary).withOpacity(0.1),
        textTheme: Theme.of(context)
            .textTheme
            .apply(
                fontFamily: fontFamily,
                fontSizeDelta: fontSizeDelta,
                displayColor: Color(darkThemeConfig.textHead),
                bodyColor: Color(darkThemeConfig.textBody))
            .copyWith(
                overline: Theme.of(context).textTheme.overline.copyWith(
                    color: Color(darkThemeConfig.textBody),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                caption: Theme.of(context).textTheme.caption.copyWith(
                    color: Color(darkThemeConfig.textBody),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Color(darkThemeConfig.textBody),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Color(darkThemeConfig.textHead),
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                headline6: Theme.of(context).textTheme.headline6.copyWith(
                    color: Color(darkThemeConfig.textHead),
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                headline5: Theme.of(context).textTheme.headline5.copyWith(
                    color: Color(darkThemeConfig.textHead),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    fontFamily: fontFamily),
                headline4: Theme.of(context).textTheme.headline4.copyWith(
                    color: Color(darkThemeConfig.textHead),
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                    fontFamily: fontFamily)),
        appBarTheme: AppBarTheme(elevation: 0.0, color: Color(darkThemeConfig.surfaceDim)),
        colorScheme: Theme.of(context).colorScheme.copyWith(onPrimary: TinyColor(Color(lightThemeConfig.primary)).isLight() ? Colors.black : Colors.white));
  }
}

class DynamicThemeHelper extends InheritedWidget {
  final ThemeData theme;
  final GlobalKey _appThemeKey;

  DynamicThemeHelper({appThemeKey, this.theme, child})
      : _appThemeKey = appThemeKey,
        super(child: child);

  set primary(Color newPrimary) {
    (_appThemeKey.currentState as DynamicThemeState)?.primary = newPrimary;
  }

  static DynamicThemeHelper of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DynamicThemeHelper>();
  }

  @override
  bool updateShouldNotify(DynamicThemeHelper oldWidget) {
    return false;
  }
}
