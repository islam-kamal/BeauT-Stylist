// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tinycolor/tinycolor.dart';
//
// import 'colors.dart';
//
// Widget buildThemeData(BuildContext context, Widget navigator, bool isShatta) {
//   var currentLanguage = Intl.getCurrentLocale();
//   var fontFamily = currentLanguage == 'ar' ? 'OpenSans' : 'OpenSans';
//   var fontSizeDelta = currentLanguage == 'ar' ? 0.0 : 0.0;
//   var shattaTheme = ThemeData(
//     fontFamily: "OpenSans",
//     primaryColor: Color(MyColors['primary']),
//     accentColor: Color(MyColors['secondary']),
//     backgroundColor: Color(MyColors['surface-dim']),
//     scaffoldBackgroundColor: Color(MyColors['surface-bright']),
//     bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
//     dividerColor: Color(MyColors['border']),
//     cardColor: Color(MyColors['surface-bright']),
//     highlightColor: Color(MyColors['primary']).withOpacity(0.1),
//     colorScheme: Theme.of(context).colorScheme.copyWith(
//           onPrimary: TinyColor(Color(MyColors['primary'])).isLight()
//               ? Colors.black
//               : Colors.white,
//           onBackground: TinyColor(Color(MyColors['surface-bright'])).isLight()
//               ? Colors.black
//               : Colors.white,
//         ),
//     textTheme: Theme.of(context)
//         .textTheme
//         .apply(
//             fontFamily: fontFamily,
//             fontSizeDelta: fontSizeDelta,
//             displayColor: Color(MyColors['text-head']),
//             bodyColor: Color(MyColors['text-body']))
//         .copyWith(
//           overline: Theme.of(context).textTheme.overline.copyWith(
//               color: Color(MyColors['text-body']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           caption: Theme.of(context).textTheme.caption.copyWith(
//               color: Color(MyColors['text-body']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           body1: Theme.of(context).textTheme.body1.copyWith(
//               color: Color(MyColors['text-body']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           subhead: Theme.of(context).textTheme.subhead.copyWith(
//               color: Color(MyColors['text-head']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           title: Theme.of(context).textTheme.title.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 18.0,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           headline: Theme.of(context).textTheme.headline.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 20.0,
//               fontWeight: FontWeight.w500,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           display1: Theme.of(context).textTheme.display1.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 24.0,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           display2: Theme.of(context).textTheme.display2.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 22.0,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//         ),
//     pageTransitionsTheme: PageTransitionsTheme(builders: {
//       TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
//       TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder()
//     }),
//     appBarTheme: AppBarTheme(
//       elevation: 0.0,
//       color: Color(MyColors['surface-bright']),
//     ),
//   );
//   var sherryTheme = ThemeData(
//     primaryColor: Color(MyColors['primary']),
//     accentColor: Color(MyColors['secondary']),
//     backgroundColor: Color(MyColors['surface-bright']),
//     scaffoldBackgroundColor: Color(MyColors['surface-dim']),
//     bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
//     dividerColor: Color(MyColors['border']),
//     cardColor: Color(MyColors['surface-dim']),
//     highlightColor: Color(MyColors['primary']).withOpacity(0.1),
//     colorScheme: Theme.of(context).colorScheme.copyWith(
//           onPrimary: TinyColor(Color(MyColors['primary'])).isLight()
//               ? Colors.black
//               : Colors.white,
//           onBackground: TinyColor(Color(MyColors['surface-bright'])).isLight()
//               ? Colors.black
//               : Colors.white,
//         ),
//     textTheme: Theme.of(context)
//         .textTheme
//         .apply(
//           fontFamily: fontFamily,
//           fontSizeDelta: fontSizeDelta,
//           displayColor: Color(MyColors['text-head']),
//           bodyColor: Color(MyColors['text-body']),
//         )
//         .copyWith(
//           overline: Theme.of(context).textTheme.overline.copyWith(
//               color: Color(MyColors['text-body']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           caption: Theme.of(context).textTheme.caption.copyWith(
//               color: Color(MyColors['text-body']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           body1: Theme.of(context).textTheme.body1.copyWith(
//               color: Color(MyColors['text-body']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           subhead: Theme.of(context).textTheme.subhead.copyWith(
//               color: Color(MyColors['text-head']),
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           title: Theme.of(context).textTheme.title.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 18.0,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           headline: Theme.of(context).textTheme.headline.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 20.0,
//               fontWeight: FontWeight.w500,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           display1: Theme.of(context).textTheme.display1.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 24.0,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//           display2: Theme.of(context).textTheme.display2.copyWith(
//               color: Color(MyColors['text-head']),
//               fontSize: 22.0,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.0,
//               fontFamily: fontFamily),
//         ),
//     pageTransitionsTheme: PageTransitionsTheme(builders: {
//       TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
//       TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder()
//     }),
//     appBarTheme: AppBarTheme(
//       elevation: 0.0,
//       color: Color(MyColors['surface-dim']),
//     ),
//   );
//
//   return Theme(
//     data: isShatta ? shattaTheme : sherryTheme,
//     child: navigator,
//     isMaterialAppTheme: true,
//   );
// }
