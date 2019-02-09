// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'category_menu_page.dart';
import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'expanding_bottom_sheet.dart';

class ShrineApp extends StatefulWidget {
  @override
  _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp>
    with SingleTickerProviderStateMixin {
  // Controller to coordinate both the opening/closing of backdrop and sliding
  // of expanding bottom sheet.
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
      value: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: HomePage(
        backdrop: Backdrop(
          frontLayer: ProductPage(),
          backLayer:
              CategoryMenuPage(onCategoryTap: () => _controller.forward()),
          frontTitle: Text('SHOPPING APP'),
          backTitle: Text('MENU'),
          controller: _controller,
        ),
        expandingBottomSheet: ExpandingBottomSheet(hideController: _controller),
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _fStarterTheme,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => LoginPage(),
    fullscreenDialog: true,
  );
}

final ThemeData _fStarterTheme = _buildFlutterTheme();

ThemeData _buildFlutterTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: fStarterColorScheme,
    accentColor: fColorOrange,
    primaryColor: fColorOrange,
    buttonColor: fColorOrange,
    scaffoldBackgroundColor: fColorBackgroundGrey,
    cardColor: fColorBackgroundWhite,
    textSelectionColor: fColorGreen100,
    errorColor: fColorErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: fStarterColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    textTheme: _buildAppTextTheme(base.textTheme),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
        color: fColorBackgroundWhite
    ),
  );
}

const ColorScheme fStarterColorScheme = ColorScheme(
  primary: fColorOrange,
  primaryVariant: fColorOrange,
  secondary: fColorCyan600,
  secondaryVariant: fColorCyan600,
  surface: fColorSurfaceWhite,
  background: fColorBackgroundWhite,
  error: fColorErrorRed,
  onPrimary: fColorOrange,
  onSecondary: fColorCyan900,
  onSurface: fColorSurfaceWhite,
  onBackground: fColorCyan900,
  onError: Colors.white,
  brightness: Brightness.dark,
);

TextTheme _buildAppTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  ).apply(
      fontFamily: 'ZillaSlab',
      displayColor: fColorBackgroundWhite,
      bodyColor: fColorBackgroundWhite
  );
}
